variable "subnet_id" {
  description = "Specify the Subnet-id to attach with NSG"
  type        = string

  validation {
    condition     = length(var.subnet_id) > 0
    error_message = "Subnet-id cannot be empty for Subnet-NSG association."
  }
}


variable "network_security_group_id" {
  description = "Specify the network_security_group_id to associate with Subnet"
  type        = string

  validation {
    condition     = length(var.network_security_group_id) > 0
    error_message = "network_security_group_id cannot be empty for Subnet-NSG association."
  }
}

