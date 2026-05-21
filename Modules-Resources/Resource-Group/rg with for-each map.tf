resource "azurerm_resource_group" "rg2" {

  for_each = {
    rg1 = "centralindia"
    rg2 = "eastus"
    rg3 = "westus"
  }

  name     = each.key
  location = each.value
}