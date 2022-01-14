resource "aws_dms_replication_instance" "primary" {
  for_each = {
    postgres = {}
    mysql    = {}
  }
  replication_instance_class = "dms.t3.large"
  replication_instance_id    = "shem-dms-test-replication-${each.key}"
  engine_version             = "3.4.6"
  availability_zone          = "us-east-2b"
}

data "terraform_remote_state" "source_dbs" {
  backend = "s3"

  config = {
    bucket  = "shem-tf-backend"
    encrypt = true
    key     = "db/terraform.tfstate"
    profile = "dev"
    region  = "us-east-2"
  }
}

data "terraform_remote_state" "target_dbs" {
  backend = "s3"

  config = {
    bucket  = "shem-tf-backend"
    encrypt = true
    key     = "stage/db/terraform.tfstate"
    profile = "dev"
    region  = "us-east-2"
  }
}

resource "aws_dms_endpoint" "source_endpoint" {
  for_each = data.terraform_remote_state.source_dbs.outputs.dbs

  endpoint_id   = "${each.value.name}-dms-endpoint"
  endpoint_type = "source"
  engine_name   = each.value.engine == "aurora-mysql" ? "aurora" : each.value.engine
  server_name   = each.value.servers.writer
  port          = each.value.port
  database_name = each.value.database
  username      = each.value.username

  password = data.terraform_remote_state.source_dbs.outputs.master_pass
}

resource "aws_dms_endpoint" "destination_endpoint" {
  for_each = data.terraform_remote_state.target_dbs.outputs.dbs

  endpoint_id   = "${each.value.name}-dms-endpoint"
  endpoint_type = "target"
  engine_name   = each.value.engine == "aurora-mysql" ? "aurora" : each.value.engine
  server_name   = each.value.servers.writer
  port          = each.value.port
  database_name = each.value.database

  username = each.value.username

  password = data.terraform_remote_state.target_dbs.outputs.master_pass
}

resource "aws_dms_replication_task" "postgres_tasks" {
  for_each = var.tasks

  migration_type           = each.value.type
  replication_instance_arn = aws_dms_replication_instance.primary[each.value.db].replication_instance_arn
  replication_task_id      = "shem-test-migration-${replace(each.key, "_", "-")}"

  table_mappings = each.value.mapping != null ? jsonencode(each.value.mapping) : <<EOF
{
  "rules": [
    {
      "rule-type": "selection",
      "rule-id": 1,
      "rule-name": "${each.value.type}-${each.value.table}",
      "object-locator": {
        "schema-name": "dms_sample",
        "table-name": "${each.value.table}"
      },
      "rule-action": "include"
    }
  ]
}
EOF

  source_endpoint_arn = aws_dms_endpoint.source_endpoint[each.value.db].endpoint_arn
  target_endpoint_arn = aws_dms_endpoint.destination_endpoint[each.value.db].endpoint_arn
}

