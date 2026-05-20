variable "name" {
  description = "Specify Name of Public-IP"
  type        = string

  validation {
    condition     = length(var.name) > 0
    error_message = "Name cannot be empty for Public_IP"
  }
}


variable "resource_group_name" {
  description = "Specify Resource Group Name for Public-IP"
  type        = string

  validation {
    condition     = length(var.resource_group_name) > 0
    error_message = "Resource Group Name cannot be empty for Public-IP"
  }
}


variable "location" {
  description = "Specify the Region for Public-IP"
  type        = string

  validation {
    condition     = contains(["centralindia", "eastus", "westus2"], lower(var.location))
    error_message = "This region is not allowed for Public-ip. Allowed regions are centralindia, eastus, westus2"
  }
}

variable "allocation_method" {
  description = "Specify Allocation method either Static or Dynamic"
  type        = string

  validation {
    condition     = contains(["static", "dynamic"], lower(var.allocation_method))
    error_message = "Value is not allowed, Use either static or dynamic "
  }
}


variable "environment" {
  description = "Specify resource environment for Public-IP"
  type        = string

  validation {
    condition     = contains(["dev", "test", "prod"], lower(var.environment))
    error_message = "Not a valid environment for public-ip, Allowed environment are dev, test, prod"
  }
}

variable "tags" {
  description = "Add the tags for Public-IP, if needed (max-10)"
  type        = map(string)

  validation {
    condition     = length(var.tags) <= 10
    error_message = "Too many tags, Maximum 10 tags are allowed"
  }
}


