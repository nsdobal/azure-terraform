resource "azurerm_resource_group" "rg3" {

  for_each = toset(["rg-x", "rg-y", "rg-z"])

  name     = each.value
  location = "centralindia"
}