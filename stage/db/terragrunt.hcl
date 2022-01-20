include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "git::git@github.com:shem-caylent/dms-learning//modules/migration_dbs"
}

inputs = {
  direction = "destination"
}
