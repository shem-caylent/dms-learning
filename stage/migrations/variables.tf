variable "tasks" {
  type = map(object({
    type  = string
    db    = string
    table = string
    mapping = map(list(object({
      rule-type      = string
      rule-id        = number
      rule-name      = string
      object-locator = map(string)
      rule-action    = string
    })))
  }))
  description = "A mapping of tasks to run on DMS"
}
