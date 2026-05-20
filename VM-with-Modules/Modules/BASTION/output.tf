output "name" {value = azurerm_bastion_host.bastion.name}
output "location" {value = azurerm_bastion_host.bastion.location}
output "virtual_network_id" {value = azurerm_bastion_host.bastion.virtual_network_id}
output "sku" {value = azurerm_bastion_host.bastion.sku}
output "ipconfig_name" {value = azurerm_bastion_host.bastion.ip_configuration[0].name}
output "ipconfig_subnet_id" {value = azurerm_bastion_host.bastion.ip_configuration[0].subnet_id}
output "ipconfig_pip_id" {value = azurerm_bastion_host.bastion.ip_configuration[0].public_ip_address_id}


### output attributes

output "bation_id" {value = azurerm_bastion_host.bastion.id}
output "dns_name" {value = azurerm_bastion_host.bastion.dns_name}
output "private_only_enabled" {value = azurerm_bastion_host.bastion.private_only_enabled}