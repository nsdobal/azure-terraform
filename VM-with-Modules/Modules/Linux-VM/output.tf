output "vm-name" { value = azurerm_linux_virtual_machine.Linux-VM.name }
output "vm-id" { value = azurerm_linux_virtual_machine.Linux-VM.id }
output "vm-private_ip_address" { value = azurerm_linux_virtual_machine.Linux-VM.private_ip_address }
output "vm-public_ip_address" { value = azurerm_linux_virtual_machine.Linux-VM.public_ip_address }
output "vm-virtual_machine_id" { value = azurerm_linux_virtual_machine.Linux-VM.virtual_machine_id }

output "vm-location" { value = azurerm_linux_virtual_machine.Linux-VM.location }
output "vm-resource_group_name" { value = azurerm_linux_virtual_machine.Linux-VM.resource_group_name }
output "vm-network_interface_ids" { value = azurerm_linux_virtual_machine.Linux-VM.network_interface_ids }
output "vm-size" { value = azurerm_linux_virtual_machine.Linux-VM.size }
output "vm-priority" { value = azurerm_linux_virtual_machine.Linux-VM.priority }


####


output "nic-name" { value = azurerm_network_interface.nic.name }
output "nic-id" { value = azurerm_network_interface.nic.id }

#output attributes
output "nic-applied_dns_servers" { value = azurerm_network_interface.nic.applied_dns_servers }
output "nic-private_ip_address" { value = azurerm_network_interface.nic.private_ip_address }
output "nic-virtual_machine_id" { value = azurerm_network_interface.nic.virtual_machine_id }
