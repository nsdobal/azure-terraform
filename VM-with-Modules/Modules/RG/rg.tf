resource "azurerm_resource_group" "rg" {
  name     = var.name
  location = var.location

  tags = merge({ environment = var.environment }, var.tags)
}