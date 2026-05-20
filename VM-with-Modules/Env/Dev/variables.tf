#### RG ####

variable "rg" {
  type = map(object({
    name        = string
    location    = string
    environment = string
    tags        = optional(map(string), {})
  }))
}

#### VNET ####

variable "vnets" {
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    address_space       = list(string)
    dns_servers         = list(string)
    environment         = string
    tags                = optional(map(string), {})
  }))
}


#### SUBNET ####

variable "subnets" {
  type = map(object({
    name                 = string
    resource_group_name  = string
    virtual_network_name = string
    address_prefixes     = list(string)
    service_endpoints    = optional(list(string), [])
  }))
}

#### PIP ####

variable "pip" {
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    allocation_method   = string
    environment         = string
    tags                = optional(map(string), {})
  }))
}


#### NSG ####

variable "nsg" {
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    environment         = string
    tags                = optional(map(string), {})
  }))
}

#### NSG RULES ####

variable "rules" {
  type = map(object({
    name                        = string
    resource_group_name         = string
    network_security_group_name = string
    priority                    = number
    direction                   = string
    access                      = string
    protocol                    = string
    source_port_range           = string
    destination_port_ranges     = list(string)
    source_address_prefix       = string
    destination_address_prefix  = string
  }))
}

#### NSG Attach ####

variable "nsg-attach" {
  type = map(object({
    subnet                 = string
    network_security_group = string
  }))
}

#### Linux VM ####

variable "Linux-VMs" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string

    vnet   = optional(string, "")
    subnet = string
    # network_interface_ids = list(string)
    enable_pip = optional(bool, false)
    pip        = optional (string)
    nsg        = optional(string, "")

    size = string

    os_disk = object({
      storage_account_type = optional(string, "Standard_LRS")
    })
    storage_account_type = optional(string, "Standard_LRS")

    source_image_reference = object({
      publisher = optional(string, "Canonical")
      offer     = optional(string, "0001-com-ubuntu-server-jammy")
      sku       = optional(string, "22_04-lts")
      version   = optional(string, "latest")
    })

    admin_username = optional(string, "azure")
    admin_password = optional(string, "Welcome@12345")
    environment    = string
    tags           = optional(map(string), {})
  }))
}


#### Bastion ####

variable "bastion" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    vnet                = string
    sku                 = optional(string, "Basic")
    ip_configuration = object({
      name   = string
      subnet = string
      pip    = string
    })
    tags = optional(map(string), {})
  }))
}


#### Windows VM ####

variable "vms" {
  type = map(object({
    name                = string
    location            = optional(string)
    resource_group_name = optional(string)
    enable_pip          = optional(bool)

    subnet            = string
    public_ip_address = optional(string)

    vm_size = string
    # license_type                  = optional(string)

    admin_username = optional(string)
    admin_password = optional(string)

    # storage_os_disk = optional (object({
    #   name          = optional(string)
    #   create_option = optional(string)
    #   caching       = optional(string)
    #   disk_size_gb  = optional(string)
    #   os_type       = optional(string)
    # }))

    storage_image_reference = optional(object({
      publisher = optional(string)
      offer     = optional(string)
      sku       = optional(string)
      version   = optional(string)
    }))

    environment = optional(string)
    tags        = optional(map(string))
  }))
}

