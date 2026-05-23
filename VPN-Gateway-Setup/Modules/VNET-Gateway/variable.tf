variable "name" {
  description = "Specify the Name of VPN-Gateway"
  type        = string

  validation {
    condition     = length(var.name) > 0
    error_message = "Subnet name cannot be empty for Subnet"
  }
}

variable "location" {
  type        = string
}

variable "resource_group_name" {
  type        = string
}

variable "sku" {
    type = string   # Basic
}

variable "type" {
  type = string     # Vpn
}

variable "vpn_type" {
  type = string     # RouteBased
}

variable "public_ip_address_id" {
  type = string     # optional
}

variable "subnet_id" {
  type = string   # Must be GatewaySubnet
}

variable "address_space" {
    type = list(string)
    nullable = true
    default = null
}

# variable "virtual_network_gateway_client_connection" {
#     type = map(object ({
#         name = string
#         policy_group_names = list(string)
#         address_prefixes = list(string)
#     })) 

#     nullable = true
#     default = null
# }