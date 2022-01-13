output "master_pass" {
  value = random_password.password.result
  sensitive = true
}

output "dbs" {
  value = {
    myql = {
      username = module.destination_mysql_db.username
      database = module.destination_mysql_db.database
      engine = module.destination_mysql_db.engine
      name = module.destination_mysql_db.name
      endpoint_url = module.destination_mysql_db.endpoint
      servers = module.destination_mysql_db.servers
      port = module.destination_mysql_db.port
    }
    postgres = {
      username = module.destination_postgres_db.username
      database = module.destination_postgres_db.database
      engine = module.destination_postgres_db.engine
      name = module.destination_postgres_db.name
      endpoint_url = module.destination_postgres_db.endpoint
      servers = module.destination_postgres_db.servers
      port = module.destination_postgres_db.port
    }
  }
}

output "mysql_url" {
  value = module.destination_mysql_db.endpoint
}

output "postgres_url" {
  value = module.destination_postgres_db.endpoint
}
