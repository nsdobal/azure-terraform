resource "azurerm_network_security_group" "nsg" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  tags = merge({ environment = var.environment }, var.tags)
}