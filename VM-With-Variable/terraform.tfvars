rg_name     = "nd-vm-rg"
rg_location = "eastus"

vm = {
  ND-VM = {
    vm_location = "centralindia"
    vm_size     = "Standard_D2s_v3"
    vm_priority = "Regular"

    os_type = "ubuntu"
  }

   VM1 = {
    vm_location = "centralindia"
    vm_size     = "Standard_D2s_v3"
    vm_priority = "Regular"

    os_type = "ubuntu"
  } 
}

source_image_reference = {
  ubuntu = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

#  windows = {
#    publisher = "MicrosoftWindowsServer"
#    offer     = "WindowsServer"
#    sku       = "2019-Datacenter"
#    version   = "latest"
#  }
}
