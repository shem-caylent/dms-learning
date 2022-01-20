locals {
  db_parameters = {
    mysql = {
      binlog_checksum = "NONE"
      binlog_format = "ROW"
      binlog_row_image = "full"
    }
    postgresql = {
      "rds.logical_replication" = 1
      max_wal_senders = 10
      wal_sender_timeout = 0
      max_logical_replication_workers = 8
      max_parallel_workers = 4
      max_worker_processes = 32
    }
  }
  family = {
    mysql = "mysql5.7"
    postgresql = "postgresql11"
  }
}

resource "aws_rds_cluster_parameter_group" "db_parameters" {
  name = "rds-${var.prefix}-${var.type}-${replace(replace(var.engine_version, ".", "-"), "_", "-")}"
  family = local.family[var.type]
  description = "Parameter group for replication and cdc"

  dynamic "parameter" {
    for_each = local.db_parameters[var.type]

    content {
      name = parameter.key
      value = parameter.value
      apply_method = "pending-reboot"
    }
  }

}

resource "aws_rds_cluster" "db" {
  cluster_identifier = "${var.prefix}-${var.type}"
  engine = "aurora-${var.type}"
  engine_version = var.engine_version
  availability_zones = ["us-east-2a", "us-east-2b", "us-east-2c"]
  database_name = "test"
  master_username = "caylent"
  master_password = var.admin_password
  backup_retention_period = 1
  preferred_backup_window = "02:00-04:00"
  skip_final_snapshot = true
  final_snapshot_identifier = "${var.prefix}-${var.type}-final"
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.db_parameters.name
}

resource "aws_rds_cluster_instance" "db_instances" {
  count = var.instance_count
  identifier = "${var.prefix}-${var.type}-${count.index}"
  cluster_identifier = aws_rds_cluster.db.id
  instance_class = var.instance_class
  engine = "aurora-${var.type}"
  engine_version = var.engine_version
}
