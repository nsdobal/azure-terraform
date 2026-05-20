variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "virtual_network_id" {
    type = string  
}

variable "sku" {
    type = string

    # validation {
    #   condition = contains("Developer","Basic","Standard","Premium",var.sku)
    #   error_message = "This is not valid sku, lookup the sku"
    # }
}

variable "ip_configuration" {
  type = object({
    name = string
    subnet_id = string
    public_ip_address_id = string
  })
}

variable "tags" {
    type = map(string)
}

