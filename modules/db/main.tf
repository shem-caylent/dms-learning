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
}

resource "aws_rds_cluster_instance" "db_instances" {
  count = var.instance_count
  identifier = "${var.prefix}-${var.type}-${count.index}"
  cluster_identifier = aws_rds_cluster.db.id
  instance_class = var.instance_class
  engine = "aurora-${var.type}"
  engine_version = var.engine_version
}

resource "aws_rds_cluster_endpoint" "db_endpoint" {
  cluster_identifier = aws_rds_cluster.db.id
  cluster_endpoint_identifier = "${var.prefix}-${var.type}-main"
  custom_endpoint_type = "ANY"
}
