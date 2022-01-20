include "root" {
  path = find_in_parent_folders()
}

dependency "dev/db" {
  config_path = "../../dev/db"
}

dependency "stage/db" {
  config_path = "../db"
}
