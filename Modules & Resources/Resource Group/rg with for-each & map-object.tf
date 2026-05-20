variable "rgmap" {
  type = map(object({
    name        = optional(string)
    location    = string
    environment = optional(string)
    tags        = optional(map(string))
  }))

  default = {
    rg-map1 = {
      name        = "rg-map1"
      location    = "centralindia"
      environment = "dev"
      tags = {
        managed_by = "terraform"
      }
    }
  }
}

#___________________________________________________________

resource "azurerm_resource_group" "rg4" {
  for_each = var.rgmap

  name     = each.key
  location = each.value.location
  tags     = merge({ environment = each.value.environment }, each.value.tags)

}


#___________________________________________________________


resource "azurerm_resource_group" "rg5" {
  for_each = {
    rg-map2 = {
      name        = "rg-map2"
      location    = "centralindia"
      environment = "dev"
      tags = {
        managed_by = "terraform"
      }
    }
  }

  name     = each.key
  location = each.value.location
  tags     = merge({ environment = each.value.environment }, each.value.tags)

}