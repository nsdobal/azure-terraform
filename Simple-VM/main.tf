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
  name     = "ND-RG"
  location = "centralindia"
}


################ VNET ################

resource "azurerm_virtual_network" "vnet" {
  name                = "vm-vnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.0.0.0/16"]
}


############## SUBNET ###################

resource "azurerm_subnet" "subnet" {
  name                 = "vm_subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}


############## Public IP Creation ##########

resource "azurerm_public_ip" "pip" {
  name                = "vm-pip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
}

################# NIC Creation ############

resource "azurerm_network_interface" "nic" {
  name                = "vm-nic"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}

############### NSG #################

resource "azurerm_network_security_group" "nsg" {
  name                = "vm-nsg"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

################ Rules ##############

resource "azurerm_network_security_rule" "rules" {
  resource_group_name = azurerm_resource_group.rg.name

  name      = "allow-port-all"
  priority  = "1000"
  direction = "Inbound"
  access    = "Allow"
  protocol  = "Tcp"

  source_address_prefix      = "*"
  source_port_range          = "*"
  destination_address_prefix = "*"
  destination_port_range     = "*"

  network_security_group_name = azurerm_network_security_group.nsg.name
}


################## NSG Attach ##############

resource "azurerm_network_interface_security_group_association" "nsg-attach" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}


################# VM Creation #############

resource "azurerm_linux_virtual_machine" "vm" {
  name                = "nd-vm"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  size     = "Standard_D2s_v3"
  priority = "Regular"

  admin_username                  = "azure"
  admin_password                  = "Welcome@12345"
  disable_password_authentication = "false"

  network_interface_ids = [azurerm_network_interface.nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

