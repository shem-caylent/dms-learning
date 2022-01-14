output "endpoint" {
  value = aws_rds_cluster_endpoint.db_endpoint.endpoint
}

output "database" {
  value = aws_rds_cluster.db.database_name
}

output "username" {
  value = aws_rds_cluster.db.master_username
}

output "engine" {
  value = aws_rds_cluster.db.engine
}

output "name" {
  value = aws_rds_cluster.db.id
}

output "port" {
  value = aws_rds_cluster.db.port
}

output "servers" {
  value = {
    reader = aws_rds_cluster.db.reader_endpoint
    writer = aws_rds_cluster.db.endpoint
  }
}
