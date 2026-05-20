output "name" {value = azurerm_network_security_rule.rules.name}
output "id" {value = azurerm_network_security_rule.rules.id}
output "network_security_group_name" {value = azurerm_network_security_rule.rules.network_security_group_name}
output "resource_group_name" {value = azurerm_network_security_rule.rules.resource_group_name}
output "priority" {value = azurerm_network_security_rule.rules.priority}
output "direction" {value = azurerm_network_security_rule.rules.direction}
output "access" {value = azurerm_network_security_rule.rules.access}
output "protocol" {value = azurerm_network_security_rule.rules.protocol}
output "source_port_range" {value = azurerm_network_security_rule.rules.source_port_range}
output "destination_port_ranges" {value = azurerm_network_security_rule.rules.destination_port_ranges}
output "source_address_prefix" {value = azurerm_network_security_rule.rules.source_address_prefix}
output "destination_address_prefix" {value = azurerm_network_security_rule.rules.destination_address_prefix}

