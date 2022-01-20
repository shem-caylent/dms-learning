tasks = {
  postgres_tier_1 = {
    type  = "full-load-and-cdc"
    db    = "postgres"
    table = "%_data"
    mapping = null
  }
  postgres_tier_2 = {
    type  = "full-load-and-cdc"
    db    = "postgres"
    table = "%_type"
    mapping = null
  }
  postgres_tier_3 = {
    type = "full-load-and-cdc"
    db   = "postgres"
    table = ""
    mapping = {
      rules = [
        {
          rule-type = "selection"
          rule-id   = 1
          rule-name = "league"
          object-locator = {
            schema-name = "dms_sample"
            table-name  = "sport_league"
          }
          rule-action = "include"
        },
        {
          rule-type = "selection"
          rule-id   = 2
          rule-name = "location"
          object-locator = {
            schema-name = "dms_sample"
            table-name  = "sport_location"
          }
          rule-action = "include"
        },
        {
          rule-type = "selection"
          rule-id   = 3
          rule-name = "person"
          object-locator = {
            schema-name = "dms_sample"
            table-name  = "person"
          }
          rule-action = "include"
        }
      ]
    }
  }
  postgres_tier_4 = {
    type = "full-load-and-cdc"
    db   = "postgres"
    table = ""
    mapping = {
      rules = [
        {
          rule-type = "selection"
          rule-id   = 1
          rule-name = "league"
          object-locator = {
            schema-name = "dms_sample"
            table-name  = "sport_division"
          }
          rule-action = "include"
        },
        {
          rule-type = "selection"
          rule-id   = 2
          rule-name = "league"
          object-locator = {
            schema-name = "dms_sample"
            table-name  = "seat"
          }
          rule-action = "include"
        },
      ]
    }
  }
  postgres_tier_5 = {
    type = "full-load-and-cdc"
    db   = "postgres"
    table = "sport_team"
    mapping = null
  }
  postgres_tier_6 = {
    type = "full-load-and-cdc"
    db   = "postgres"
    table = ""
    mapping = {
      rules = [
        {
          rule-type = "selection"
          rule-id   = 1
          rule-name = "league"
          object-locator = {
            schema-name = "dms_sample"
            table-name  = "player"
          }
          rule-action = "include"
        },
        {
          rule-type = "selection"
          rule-id   = 2
          rule-name = "league"
          object-locator = {
            schema-name = "dms_sample"
            table-name  = "sporting_event"
          }
          rule-action = "include"
        },
      ]
    }
  }
  postgres_tier_7 = {
    type = "full-load-and-cdc"
    db    = "postgres"
    table = "sporting_event_ticket"
    mapping = null
  }
  postgres_tier_8 = {
    type = "full-load-and-cdc"
    db    = "postgres"
    table = "ticket_purchase_hist"
    mapping = null
  }
  mysql_tier_1 = {
    type  = "full-load-and-cdc"
    db    = "mysql"
    table = "%_data"
    mapping = null
  }
  mysql_tier_2 = {
    type  = "full-load-and-cdc"
    db    = "mysql"
    table = "%_type"
    mapping = null
  }
  mysql_tier_3 = {
    type = "full-load-and-cdc"
    db   = "mysql"
    table = ""
    mapping = {
      rules = [
        {
          rule-type = "selection"
          rule-id   = 1
          rule-name = "league"
          object-locator = {
            schema-name = "dms_sample"
            table-name  = "sport_league"
          }
          rule-action = "include"
        },
        {
          rule-type = "selection"
          rule-id   = 2
          rule-name = "location"
          object-locator = {
            schema-name = "dms_sample"
            table-name  = "sport_location"
          }
          rule-action = "include"
        },
        {
          rule-type = "selection"
          rule-id   = 3
          rule-name = "person"
          object-locator = {
            schema-name = "dms_sample"
            table-name  = "person"
          }
          rule-action = "include"
        }
      ]
    }
  }
}
