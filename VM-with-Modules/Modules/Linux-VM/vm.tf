resource "azurerm_network_interface" "nic" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.enable_pip ? var.public_ip_address_id : null
  }

  tags = merge({ environment = var.environment }, var.tags)
}


resource "azurerm_linux_virtual_machine" "Linux-VM" {
  name                  = var.name
  location              = var.location
  resource_group_name   = var.resource_group_name

  network_interface_ids = [azurerm_network_interface.nic.id]

  size     = var.size
  priority = "Regular"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.os_disk.storage_account_type
  }

  source_image_reference {
    publisher = var.source_image_reference.publisher
    offer     = var.source_image_reference.offer
    sku       = var.source_image_reference.sku
    version   = var.source_image_reference.version
  }

  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = false


  tags = merge({ environment = var.environment }, var.tags)
}