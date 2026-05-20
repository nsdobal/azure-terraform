resource "azurerm_network_interface" "nic" {
    name = "${var.name}-nic"
    location = var.location
    resource_group_name = var.resource_group_name

    ip_configuration {
        name = "${var.name}-ipconfig"
        subnet_id = var.subnet_id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id = var.enable_pip ? var.public_ip_address_id : null
    }  
}


resource "azurerm_virtual_machine" "vm" {
    name = var.name
    location = var.location
    resource_group_name = var.resource_group_name
    network_interface_ids = [azurerm_network_interface.nic.id]
    vm_size = var.vm_size

    os_profile_windows_config {}

    delete_os_disk_on_termination = local.delete_os_disk_on_termination
    license_type = local.license_type

    storage_os_disk {
      name = local.storage_os_disk.name
      create_option = local.storage_os_disk.create_option
      caching = local.storage_os_disk.caching
      disk_size_gb = local.storage_os_disk.disk_size_gb
      os_type = local.storage_os_disk.os_type
    }

    os_profile {
      computer_name = "${var.name}-os"
      admin_username = var.admin_username
      admin_password = var.admin_password
    }

    tags = merge(var.environment==null ? {} :
      {environment = var.environment},var.tags)

    storage_image_reference {
      publisher = local.storage_image_reference.publisher
      offer = local.storage_image_reference.offer
      sku = local.storage_image_reference.sku
      version = local.storage_image_reference.version
    }
}