resource "aws_dms_replication_instance" "primary" {
  replication_instance_class = "dms.t3.medium"
  replication_instance_id = "shem-dms-test-replication"
  engine_version = "3.4.6"
  availability_zone = "us-east-2b"
}

data "terraform_remote_state" "source_dbs" {
  backend = "s3"

  config = {
    bucket = "shem-tf-backend"
    encrypt = true
    key = "dev/db/terraform.tfstate"
    profile = "dev"
    region = "us-east-2"
  }
}

data "terraform_remote_state" "target_dbs" {
  backend = "s3"

  config = {
    bucket = "shem-tf-backend"
    encrypt = true
    key = "stage/db/terraform.tfstate"
    profile = "dev"
    region = "us-east-2"
  }
}

resource "aws_dms_endpoint" "source_endpoint" {
  for_each = data.terraform_remote_state.source_dbs.outputs.dbs

  endpoint_id = "${each.value.name}-dms-endpoint"
  endpoint_type = "source"
  engine_name = each.value.engine == "aurora-mysql" ? "aurora" : each.value.engine
  database_name = each.value.database
  username = each.value.username

  password = data.terraform_remote_state.source_dbs.outputs.master_pass
}

resource "aws_dms_endpoint" "destination_endpoint" {
  for_each = data.terraform_remote_state.target_dbs.outputs.dbs

  endpoint_id = "${each.value.name}-dms-endpoint"
  endpoint_type = "target"
  engine_name = each.value.engine == "aurora-mysql" ? "aurora" : each.value.engine
  database_name = each.value.database

  username = each.value.username

  password = data.terraform_remote_state.target_dbs.outputs.master_pass
}

# resource "aws_dms_replication_task" "task-1" {
#   migration_type = "full-load-and-cdc"
#   replication_task_id = "task-1"
# }
