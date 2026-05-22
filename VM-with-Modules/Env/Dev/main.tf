#### RG ####

module "rg" {
  source = "../../Modules/RG"

  for_each    = var.rg
  name        = each.key
  location    = each.value.location
  environment = each.value.environment
  tags        = each.value.tags
}

#### VNET ####

module "vnet" {
  source     = "../../Modules/VNET"
  depends_on = [module.rg]

  for_each = var.vnets

  name                = each.key
  resource_group_name = module.rg[each.value.resource_group_name].rg-name
  location            = each.value.location
  address_space       = each.value.address_space
  dns_servers         = each.value.dns_servers
  environment         = each.value.environment
  tags                = each.value.tags
}

#### SUBNET ####

module "subnet" {
  source     = "../../Modules/SUBNET"
  depends_on = [module.rg, module.vnet]

  for_each = var.subnets

  name                 = each.key
  resource_group_name  = module.rg[each.value.resource_group_name].rg-name
  virtual_network_name = module.vnet[each.value.virtual_network_name].name
  address_prefixes     = each.value.address_prefixes
  service_endpoints    = each.value.service_endpoints
}

#### PIP ####

module "pip" {
  source     = "../../Modules/PIP"
  depends_on = [module.rg]

  for_each            = var.pip
  name                = each.key
  resource_group_name = module.rg[each.value.resource_group_name].rg-name
  location            = each.value.location
  allocation_method   = each.value.allocation_method
  environment         = each.value.environment
  tags                = each.value.tags
}

#### NSG ####

module "nsg" {
  source     = "../../Modules/NSG"
  depends_on = [module.rg]

  for_each            = var.nsg
  name                = each.key
  resource_group_name = module.rg[each.value.resource_group_name].rg-name
  location            = each.value.location
  environment         = each.value.environment
  tags                = each.value.tags
}

#### NSG Rules ####

module "rules" {
  source     = "../../Modules/RULES"
  depends_on = [module.rg, module.nsg]

  for_each                    = var.rules
  name                        = each.key
  resource_group_name         = module.rg[each.value.resource_group_name].rg-name
  network_security_group_name = module.nsg[each.value.network_security_group_name].name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_ranges     = each.value.destination_port_ranges
  source_address_prefix       = each.value.source_address_prefix #module.subnet[each.value.source_address_prefix].address_prefixes[0]
  destination_address_prefix  = each.value.destination_address_prefix

}

#### NSG-Attach ####

module "nsg-attach" {
  source     = "../../Modules/NSG-ATTACH"
  depends_on = [module.subnet, module.nsg]

  for_each = var.nsg-attach

  subnet_id                 = module.subnet[each.value.subnet].id
  network_security_group_id = module.nsg[each.value.network_security_group].id

}


#### Linux-VM ####

module "Linux-VM" {
  source     = "../../Modules/Linux-VM"
  depends_on = [module.rg, module.pip, module.subnet, module.vnet]

  for_each = var.Linux-VMs

  name                = each.key
  location            = each.value.location
  resource_group_name = module.rg[each.value.resource_group_name].rg-name

  enable_pip = each.value.enable_pip
  subnet_id  = module.subnet[each.value.subnet].id
  # public_ip_address_id = module.pip[each.value.pip].id

  # network_interface_ids = [
  #     for nic in each.value.network_interface_ids :
  #     module.nic[nic].id
  #     ]

  size = each.value.size

  os_disk = {
    storage_account_type = each.value.storage_account_type
  }

  source_image_reference = {
    publisher = each.value.source_image_reference.publisher
    offer     = each.value.source_image_reference.offer
    sku       = each.value.source_image_reference.sku
    version   = each.value.source_image_reference.version
  }
  admin_username = each.value.admin_username
  admin_password = each.value.admin_password
  environment    = each.value.environment
  tags           = each.value.tags
}


#### Bastion Host ####

module "bastion" {
  source     = "../../Modules/BASTION"
  depends_on = [module.rg, module.vnet, module.vnet, module.subnet, module.pip]

  for_each            = var.bastion
  name                = each.value.name
  location            = each.value.location
  resource_group_name = module.rg[each.value.resource_group_name].rg-name
  virtual_network_id  = module.vnet[each.value.vnet].id
  sku                 = each.value.sku
  ip_configuration = {
    name                 = each.value.ip_configuration.name
    subnet_id            = module.subnet[each.value.ip_configuration.subnet].id
    public_ip_address_id = module.pip[each.value.ip_configuration.pip].id
  }
  tags = each.value.tags
}


#### Windows Machine ####

module "VM" {
  source     = "../../Modules/VM"
  depends_on = [module.rg, module.pip, module.subnet]

  for_each = local.vms_final

  name                 = each.key
  location             = each.value.location
  resource_group_name  = module.rg[each.value.resource_group_name].rg-name
  enable_pip           = each.value.enable_pip
  subnet_id            = module.subnet[each.value.subnet].id
  public_ip_address_id = each.value.public_ip_address

  vm_size        = each.value.vm_size
  admin_username = each.value.admin_username
  admin_password = each.value.admin_password

  environment = each.value.environment
  tags        = each.value.tags

  storage_image_reference = each.value.storage_image_reference

}