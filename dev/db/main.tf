resource "random_password" "password" {
  length = 12
  special = false
}

module "source_mysql_db" {
  source = "../../modules/db"

  prefix = "shem-dms-test"
  type = "mysql"
  engine_version = "5.7.mysql_aurora.2.10.1"
  admin_password = random_password.password.result
  instance_class = "db.t3.small"
}

module "source_postgres_db" {
  source = "../../modules/db"

  prefix = "shem-dms-test"
  type = "postgresql"
  engine_version = "11.13"
  admin_password = random_password.password.result
  instance_class = "db.t4g.medium"
}

