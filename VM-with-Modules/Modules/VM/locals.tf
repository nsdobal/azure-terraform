locals {
  license_type                  = "Windows_Client"
  delete_os_disk_on_termination = true

  storage_os_disk = {
    name          = "${var.name}-osdisk"
    create_option = "FromImage"
    caching       = "ReadWrite"
    disk_size_gb  = 130
    os_type       = "Windows"
  }

  storage_image_reference = merge({
    publisher = "microsoftwindowsserver"
    offer     = "windowsserver2022"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }, var.storage_image_reference)
}

