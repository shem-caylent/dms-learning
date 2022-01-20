output "master_pass" {
  value = random_password.password.result
  sensitive = true
}

output "dbs" {
  value = {
    mysql = {
      username = module.mysql_db.username
      database = module.mysql_db.database
      engine = module.mysql_db.engine
      name = module.mysql_db.name
      endpoint_url = module.mysql_db.endpoint
      servers = module.mysql_db.servers
      port = module.mysql_db.port
    }
    postgres = {
      username = module.postgres_db.username
      database = module.postgres_db.database
      engine = module.postgres_db.engine
      name = module.postgres_db.name
      endpoint_url = module.postgres_db.endpoint
      servers = module.postgres_db.servers
      port = module.postgres_db.port
    }
  }
}

output "mysql_url" {
  value = module.mysql_db.endpoint
}

output "postgres_url" {
  value = module.postgres_db.endpoint
}
