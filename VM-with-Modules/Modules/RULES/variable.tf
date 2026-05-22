variable "name" {
  description = "Specify the Rule name for NSG-Rule"
  type        = string

  validation {
    condition     = length(trimspace(var.name)) > 0
    error_message = "NSG-Rule name cannot be empty for NSG-Rules."
  }
}

variable "resource_group_name" {
  description = "Specify the Resource Group Name for NSG-Rule"
  type        = string
}

variable "network_security_group_name" {
  description = "Specify the NSG-Name for linking the NSG-Rule"
  type        = string

  validation {
    condition     = length(var.network_security_group_name) > 0
    error_message = "NSG-Name cannot be empty for NSG-Rules"
  }
}

variable "priority" {
  description = "Define the priority of Rule defined for NSG-Rule"
  type        = number

  validation {
    condition     = var.priority >= 100 && var.priority <= 4096
    error_message = "Priority is out of range, Valid range is between 100 & 4096"
  }
}


variable "direction" {
  description = "Define the rule Direction, for NSG-Rule"
  type        = string

  validation {
    condition     = contains(["inbound", "outbound"], lower(var.direction))
    error_message = "Direction is not valid for NSG-Rules, It can be either inbound or outbound"
  }
}

variable "access" {
  description = "Define the rule access-type, for NSG-Rule"
  type        = string

  validation {
    condition     = contains(["allow", "deny"], lower(var.access))
    error_message = "Access-type is not valid for NSG-Rules, It can be either allow or deny"
  }
}

variable "protocol" {
  description = "Define the protocol for NSG-Rule - Tcp, Udp, Icmp, Esp, Ah, *"
  type        = string

  validation {
    condition     = contains(["Tcp", "Udp", "Icmp", "Esp", "Ah", "*"], var.protocol)
    error_message = "Not a valid protocol for NSG-Rules, Allowed protocols are Tcp, Udp, Icmp, Esp, Ah, *"
  }
}


variable "source_port_range" {
  description = "Define list for source port range for NSG Rule"
  type        = string

  validation {
    condition     = length(var.source_port_range) > 0
    error_message = "Source_Port_Range cannot be empty, * is allowed"
  }
}


variable "destination_port_ranges" {
  description = "Define list for Destination port range for NSG Rule"
  type        = list(string)

  validation {
    condition     = length(var.destination_port_ranges) > 0
    error_message = "Destination_Port_Ranges cannot be empty, and required to be written as list."
  }
}


variable "source_address_prefix" {
  description = "Define list for Source address prefixs for NSG Rule"
  type        = string

  validation {
    condition     = length(var.source_address_prefix) > 0
    error_message = "Source_Address_Previxes cannot be empty, and required to be written as list. [*] is allowed"
  }
}


variable "destination_address_prefix" {
  description = "Define list for Destination address prefixs for NSG Rule"
  type        = string

  validation {
    condition     = length(var.destination_address_prefix) > 0
    error_message = "Destination_Address_Previxes cannot be empty, and required to be written as list. [*] is allowed"
  }
}
