resource "azurerm_bastion_host" "bastion" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  virtual_network_id  = var.sku == "Developer" ? var.virtual_network_id : null
  sku                 = var.sku

  ip_configuration {
    name                 = var.ip_configuration.name
    subnet_id            = var.ip_configuration.subnet_id
    public_ip_address_id = var.ip_configuration.public_ip_address_id
  }

  tunneling_enabled = var.sku == "Basic" ? null : true
  tags              = var.tags
}