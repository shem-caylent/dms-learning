variable "prefix" {
  type = string
  description = "Prefix for the nameing of resources"
}

variable "type" {
  type = string
  description = "One of mysql or postgresql"
  validation {
    condition = contains(["mysql", "postgresql"], var.type)
    error_message = "Unknown DB type. Must be one of `mysql`, or `postgresql`."
  }
}

variable "engine_version" {
  type = string
  description = "Engine version if needed"
  default = ""
}

variable "admin_password" {
  type = string
  description = "Password for admin user"
}

variable "instance_count" {
  type = number
  default = 2
  description = "Number of instances in the cluster"
}

variable "instance_class" {
  description = "AWS instance class for db instance"
  type = string
}
