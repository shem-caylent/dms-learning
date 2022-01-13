output "master_pass" {
  value = random_password.password.result
  sensitive = true
}

output "dbs" {
  value = {
    myql = {
      username = module.source_mysql_db.username
      database = module.source_mysql_db.database
      engine = module.source_mysql_db.engine
      name = module.source_mysql_db.name
      endpoint_url = module.source_mysql_db.endpoint
    }
    postgres = {
      username = module.source_postgres_db.username
      database = module.source_postgres_db.database
      engine = module.source_postgres_db.engine
      name = module.source_postgres_db.name
      endpoint_url = module.source_postgres_db.endpoint
    }
  }
}

output "mysql_url" {
  value = module.source_mysql_db.endpoint
}

output "postgres_url" {
  value = module.source_postgres_db.endpoint
}
