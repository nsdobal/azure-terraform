#### RG ####

rg = {

  dev-rg = {
    name        = "dev-rg"
    location    = "centralindia"
    environment = "dev"
    #   tags = {}
  }
}


#### VNET ####

vnets = {
  alzr-vnet = {
    name                = "alzr-vnet"
    resource_group_name = "dev-rg"
    location            = "centralindia"
    address_space       = ["10.0.0.0/16"]
    dns_servers         = []
    environment         = "dev"
    tags                = { owner = "nd" }
  }
}

#### Subnet ####

subnets = {

  AzureBastionSubnet = {
    name                 = "AzureBastionSubnet"
    resource_group_name  = "dev-rg"
    virtual_network_name = "alzr-vnet"
    address_prefixes     = ["10.0.0.0/24"]
    # service_endpoints =[]
  }

  Netapp-subnet = {
    name                 = "Netapp-subnet"
    resource_group_name  = "dev-rg"
    virtual_network_name = "alzr-vnet"
    address_prefixes     = ["10.0.10.0/24"]
    # service_endpoints =[]
  }

  subnet1 = {
    name                 = "subnet1"
    resource_group_name  = "dev-rg"
    virtual_network_name = "alzr-vnet"
    address_prefixes     = ["10.0.1.0/24"]
    # service_endpoints =[]
  }

  subnetfe = {
    name                 = "subnetfe"
    resource_group_name  = "dev-rg"
    virtual_network_name = "alzr-vnet"
    address_prefixes     = ["10.0.2.0/24"]
    # service_endpoints =[]
  }

}

#### PIP ####

pip = {
  bastion-pip = {
    name                = "bastion-pip"
    resource_group_name = "dev-rg"
    location            = "centralindia"
    allocation_method   = "Static"
    environment         = "dev"
    tags                = { owner = "nd" }
  }

  ag-pip = {
    name                = "ag-pip"
    resource_group_name = "dev-rg"
    location            = "centralindia"
    allocation_method   = "Static"
    environment         = "dev"
    tags                = { owner = "nd" }
  }
}


#### NSG ####

nsg = {
  nsg-1 = {
    name                = "nsg-1"
    resource_group_name = "dev-rg"
    location            = "centralindia"
    environment         = "dev"
    tags                = { bastion-nsg = "all ports open" }
  }
}

#### NSG RULES ####

rules = {
  nsg-rule-1 = {
    name                        = "nsg-rule-1"
    resource_group_name         = "dev-rg"
    network_security_group_name = "nsg-1"
    priority                    = 200
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_ranges     = ["3389"]
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
  }
}


#### NSG Attach ####

nsg-attach = {
  # "nsg-attach-AzureBastionSubnet" = {
  #   subnet                 = "AzureBastionSubnet"
  #   network_security_group = "bastion-nsg"
  # }

  "nsg-attach-vm1" = {
    subnet                 = "subnet1"
    network_security_group = "nsg-1"
  }
}


#### BASTION ####

bastion = {
  # "alzr" = {
  #   name                = "alzr"
  #   location            = "centralindia"
  #   resource_group_name = "dev-rg"
  #   vnet                = "alzr-vnet"
  #   sku                 = "Basic" # "Standard" # optional
  #   ip_configuration = {
  #     name   = "bastion_ipname"
  #     subnet = "AzureBastionSubnet"
  #     pip    = "bastion-pip"
  #   }
  #   tags = {
  #     project = "alzr"
  #     env     = "dev"
  #   }
  # }
}


#### Windows VM ####


vms = {
  # Windows-vm1 = {
  #   name                = "Windows-vm1"
  #   location            = "centralindia"
  #   resource_group_name = "dev-rg"
  #   subnet              = "subnetfe"

  #   vm_size = "Standard_B2ls_v2" # "Standard_B2ls_v2"

  #   storage_image_reference = {
  #     publisher = "microsoftwindowsserver"
  #     offer     = "windowsserver2022"
  #     sku       = "2022-datacenter-azure-edition"
  #     version   = "latest"
  #   }
  # }

  # Windows-vm2 = {
  #   name    = "Windows-vm2"
  #   subnet  = "subnetfe"
  #   vm_size = "Standard_B2ls_v2" # "Standard_B2ls_v2"
  # }
}

#### Linux VM ####

Linux-VMs = {
  # linux-vm1 = {
  #   name                = "linux-vm1"
  #   location            = "centralindia"
  #   resource_group_name = "dev-rg"

  #   vnet   = "alzr-vnet" #optional
  #   subnet = "subnet1"
  #   # network_interface_ids = ["self-nic"]
  #   enable_pip = false  # optional : default=false
  #   pip        = "pip1" #optional  : default=na
  #   nsg        = "nsg1" #optional

  #   size = "Standard_D2s_v3"

  #   os_disk = {
  #     storage_account_type = "Standard_LRS" #optional
  #   }

  #   source_image_reference = {} #arguments are optional

  #   admin_username = "azure"         #optional
  #   admin_password = "Welcome@12345" #optional

  #   environment = "dev"
  #   tags = { #optional
  #     project = "demo"
  #     owner   = "nd"
  #   }
  # }


  # vm3 = {
  #   name                = "vm3"
  #   location            = "centralindia"
  #   resource_group_name = "dev-rg"

  #   vnet   = "alzr-vnet" #optional
  #   subnet = "subnet2"
  #   # network_interface_ids = ["self-nic"]
  #   enable_pip = false
  #   pip        = "test-pip" #optional
  #   nsg        = "nsg1" #optional

  #   size = "Standard_D2s_v3"

  #   os_disk = {}

  #   source_image_reference = {} #arguments are optional

  #   environment = "dev"
  # }
}