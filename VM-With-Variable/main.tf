############# Provider ###############

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.69.0"
    }
  }
}

provider "azurerm" {
  features {}
}

############## Resource Group ##############

resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.rg_location
}

################ VNET ################

resource "azurerm_virtual_network" "vnet" {
  for_each = var.vm

  name                = "${each.key}-vnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = each.value.vm_location
  address_space       = ["10.0.0.0/16"]
}

############## SUBNET ###################

resource "azurerm_subnet" "subnet" {
  for_each = var.vm

  name                 = "${each.key}-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet[each.key].name
  address_prefixes     = ["10.0.1.0/24"]
}


############## Public IP Creation ##########

resource "azurerm_public_ip" "pip" {
  for_each = var.vm

  name                = "${each.key}-pip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = each.value.vm_location
  allocation_method   = "Static"
}

################# NIC Creation ############

resource "azurerm_network_interface" "nic" {
  for_each = var.vm

  name                = "${each.key}-nic"
  resource_group_name = azurerm_resource_group.rg.name
  location            = each.value.vm_location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet[each.key].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip[each.key].id
  }
}

############### NSG #################

resource "azurerm_network_security_group" "nsg" {
  for_each = var.vm

  name                = "${each.key}-nsg"
  resource_group_name = azurerm_resource_group.rg.name
  location            = each.value.vm_location
}

################ Rules ##############

resource "azurerm_network_security_rule" "rules" {

  for_each            = var.vm
  resource_group_name = azurerm_resource_group.rg.name

  name      = "${each.key}-allow-port22"
  priority  = "1000"
  direction = "Inbound"
  access    = "Allow"
  protocol  = "Tcp"

  source_address_prefix      = "*"
  source_port_range          = "*"
  destination_address_prefix = "*"
  destination_port_range     = "22"

  network_security_group_name = azurerm_network_security_group.nsg[each.key].name
}


################## NSG Attach ##############

resource "azurerm_network_interface_security_group_association" "nsg-attach" {
  for_each                  = var.vm
  network_interface_id      = azurerm_network_interface.nic[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
}


################## VM Creation #############

resource "azurerm_linux_virtual_machine" "vm" {
  for_each = var.vm

  name                = "${each.key}-vm"
  location            = each.value.vm_location
  resource_group_name = azurerm_resource_group.rg.name

  size     = each.value.vm_size
  priority = each.value.vm_priority

  admin_username                  = "azure"
  admin_password                  = "Welcome@12345"
  disable_password_authentication = "false"

  network_interface_ids = [azurerm_network_interface.nic[each.key].id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.source_image_reference[each.value.os_type].publisher
    offer     = var.source_image_reference[each.value.os_type].offer
    sku       = var.source_image_reference[each.value.os_type].sku
    version   = var.source_image_reference[each.value.os_type].version
  }
}



