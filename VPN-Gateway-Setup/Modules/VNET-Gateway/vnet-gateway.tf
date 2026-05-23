resource "azurerm_virtual_network_gateway" "vnet-gateway" {
    name = var.name
    location = var.location
    resource_group_name = var.resource_group_name

    type = var.type
    vpn_type = var.vpn_type
    sku = var.sku

    ip_configuration {
      name = "${var.name}-vnetgatewayconfig"
      public_ip_address_id = var.public_ip_address_id
      private_ip_address_allocation = "Dynamic"
      subnet_id = var.subnet_id
    }

    dynamic "vpn_client_configuration" {
        for_each = var.address_space != null ? [1] : []

        content {
            address_space = var.address_space
        }
    }

    # ipsec_policy {}

    # dynamic "virtual_network_gateway_client_connection" {
    #     for_each = var.virtual_network_gateway_client_connection != null ? [1] : []

    #     content {
    #         name = var.virtual_network_gateway_client_connection.name
    #         policy_group_names = var.virtual_network_gateway_client_connection.policy_group_names
    #         address_prefixes = var.virtual_network_gateway_client_connection.address_prefixes
    #     }
    # }
}