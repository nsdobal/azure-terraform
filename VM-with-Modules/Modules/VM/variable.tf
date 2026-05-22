variable "name" {
  type = string
}

variable "location" {
  type = string
  validation {
    condition     = contains(["centralindia", "eastus"], lower(var.location))
    error_message = "Only Centralindia & eastus region is allowed"
  }
}

variable "resource_group_name" {
  type = string
}

variable "enable_pip" {
  type = bool
}

variable "public_ip_address_id" { type = string }
variable "subnet_id" { type = string }

variable "vm_size" { type = string }

variable "admin_username" {
  type      = string
  sensitive = true
}
variable "admin_password" {
  type      = string
  sensitive = true
}

variable "storage_image_reference" {
  type = object({
    publisher = optional(string)
    offer     = optional(string)
    sku       = optional(string)
    version   = optional(string)
  })
  default = {}
}

variable "environment" {
  type    = string
  default = null
}
variable "tags" {
  type    = map(string)
  default = {}
}

