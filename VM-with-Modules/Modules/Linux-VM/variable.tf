variable "name" {
  description = "Specify the name for Linux-VM"
  type        = string

  validation {
    condition     = length(var.name) > 0
    error_message = "VM-Name cannot be empty for Linux-VM"
  }
}


variable "location" {
  description = "Specify the region for Linux-VM"
  type        = string

  validation {
    condition     = contains(["centralindia", "eastus", "westus2"], lower(var.location))
    error_message = "This regions is not allowed for Linux VM. Permitted regions are centralindia, eastus, westus2"
  }
}


variable "resource_group_name" {
  description = "Specify the resource_group_name for Linux-VM"
  type        = string
}

variable "subnet_id" {
  description = "Name of Subnet where this VM will be created"
  type        = string
}

variable "enable_pip" {
  type    = bool
  default = false
}

variable "public_ip_address_id" {
  description = "IP of PIP where this VM will be attached"
  type        = string
  default     = null
}

variable "size" {
  description = "Specify the size for Linux-VM - Allowed (Standard_D2s_v3)"
  type        = string

  # validation {
  #   condition     = contains(["Standard_D2s_v3"], var.size)
  #   error_message = "This vm_size is not allowed in your environment. Standard_D2s_v3 can be used for Linux VM"
  # }
}

# OS-Disk

variable "os_disk" {
  type = object({
    storage_account_type = string
  })
}

# Source Image Reference

variable "source_image_reference" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
}


variable "admin_username" {
  description = "Specify the admin_username for Linux-VM, default is azure"
  type        = string
  sensitive   = true
}
variable "admin_password" {
  description = "Specify the admin_username for Linux-VM, default is Welcome@12345"
  type        = string
  sensitive   = true
}

# Env & Tags
variable "environment" {
  description = "Specify the environment for Linux-VM"
  type        = string

  validation {
    condition     = contains(["dev", "test", "prod"], lower(var.environment))
    error_message = "This environment is not valid for Linux VM. Select from dev, test, prod"
  }
}


variable "tags" {
  description = "Specify the tags for Linux-VM - max10"
  type        = map(string)

  validation {
    condition     = length(var.tags) < 10
    error_message = "Too many tags, max 10 tags are allowed for Linux-VM"
  }
}



