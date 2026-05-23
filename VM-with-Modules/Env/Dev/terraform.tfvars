#### RG ####

rg = {

  nd-dev-rg = {
    name        = "nd-dev-rg"
    location    = "centralindia"
    environment = "dev"
    #   tags = {}
  }
}


#### VNET ####

vnets = {
  alzr-vnet = {
    name                = "alzr-vnet"
    resource_group_name = "nd-dev-rg"
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
    resource_group_name  = "nd-dev-rg"
    virtual_network_name = "alzr-vnet"
    address_prefixes     = ["10.0.1.0/24"]
    # service_endpoints =[]
  }

  subnet-ag = {
    name                 = "subnet-ag"
    resource_group_name  = "nd-dev-rg"
    virtual_network_name = "alzr-vnet"
    address_prefixes     = ["10.0.2.0/24"]
    # service_endpoints =[]
  }

  subnetfe = {
    name                 = "subnetfe"
    resource_group_name  = "nd-dev-rg"
    virtual_network_name = "alzr-vnet"
    address_prefixes     = ["10.0.3.0/24"]
    # service_endpoints =[]
  }
}

#### PIP ####

pip = {
  bastion-pip = {
    name                = "bastion-pip"
    resource_group_name = "nd-dev-rg"
    location            = "centralindia"
    allocation_method   = "Static"
    environment         = "dev"
    tags                = { owner = "nd" }
  }

  ag-pip = {
    name                = "ag-pip"
    resource_group_name = "nd-dev-rg"
    location            = "centralindia"
    allocation_method   = "Static"
    environment         = "dev"
    tags                = { owner = "nd" }
  }
}


#### NSG ####

nsg = {
  nsg-ag = {
    name                = "nsg-ag"
    resource_group_name = "nd-dev-rg"
    location            = "centralindia"
    environment         = "dev"
    # tags                = { bastion-nsg = "all ports open" }
  }
}

#### NSG RULES ####

rules = {
  nsgrules-ag-allow-http = {
    name                        = "nsgrules-ag-allow-http"
    resource_group_name         = "nd-dev-rg"
    network_security_group_name = "nsg-ag"
    priority                    = 200
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_ranges     = ["80", "443"]
    source_address_prefix       = "Internet"
    destination_address_prefix  = "*"
  }

  nsgrules-ag-allow-http-lb = {
    name                        = "nsgrules-ag-allow-http"
    resource_group_name         = "nd-dev-rg"
    network_security_group_name = "nsg-ag"
    priority                    = 201
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_ranges     = ["80", "443"]
    source_address_prefix       = "AzureLoadBalancer"
    destination_address_prefix  = "*"
  }

  allow_gateway_manager = {
    name                        = "allow-gateway-manager"
    resource_group_name         = "nd-dev-rg"
    network_security_group_name = "nsg-ag"
    priority                    = 220
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_ranges     = ["65200-65535"]
    source_address_prefix       = "GatewayManager"
    destination_address_prefix  = "*"
  }
}


#### NSG Attach ####

nsg-attach = {
  # "nsg-attach-AzureBastionSubnet" = {
  #   subnet                 = "AzureBastionSubnet"
  #   network_security_group = "bastion-nsg"
  # }

  "nsg-attach-bastion" = {
    subnet                 = "subnet-ag"
    network_security_group = "nsg-ag"
  }
}


#### BASTION ####

bastion = {
  "alzr" = {
    name                = "alzr"
    location            = "centralindia"
    resource_group_name = "nd-dev-rg"
    vnet                = "alzr-vnet"
    sku                 = "Basic" # "Standard" # optional
    ip_configuration = {
      name   = "bastion-ipname"
      subnet = "AzureBastionSubnet"
      pip    = "bastion-pip"
    }
    tags = {
      project = "alzr"
      env     = "dev"
    }
  }
}


#### Windows VM ####


vms = {
  Windows-vm1 = {
    name                = "Windows-vm1"
    location            = "centralindia"
    resource_group_name = "nd-dev-rg"
    subnet              = "subnetfe"

    vm_size = "Standard_B2ls_v2" # "Standard_B2ls_v2"

    storage_image_reference = {
      publisher = "microsoftwindowsserver"
      offer     = "windowsserver2022"
      sku       = "2022-datacenter-azure-edition"
      version   = "latest"
    }
  }

  Windows-vm2 = {
    name                = "Windows-vm2"
    resource_group_name = "nd-dev-rg"
    subnet              = "subnetfe"
    location            = "centralindia"
    vm_size             = "Standard_B2ls_v2" # "Standard_B2ls_v2"
  }
}

#### Linux VM ####

Linux-VMs = {
  # linux-vm1 = {
  #   name                = "linux-vm1"
  #   location            = "centralindia"
  #   resource_group_name = "nd-dev-rg"

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
  #   resource_group_name = "nd-dev-rg"

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