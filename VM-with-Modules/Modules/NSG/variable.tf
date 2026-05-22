variable "name" {
  description = "Specify name for NSG"
  type        = string

  validation {
    condition     = length(var.name) > 0
    error_message = "NSG Name cannot be empty for NSG"
  }
}

variable "resource_group_name" {
  description = "Specify Resource Group Name for NSG"
  type        = string
}

variable "location" {
  description = "Specify Region for NSG"
  type        = string

  validation {
    condition     = contains(["centralindia", "eastus", "westus2"], lower(var.location))
    error_message = "Region is not allowed for NSG, Allowed regions are centralindia, eastus, westus2"
  }
}

variable "environment" {
  description = "Specify Environment for NSG - dev, test, prod"
  type        = string

  validation {
    condition     = contains(["dev", "test", "prod"], lower(var.environment))
    error_message = "Unknown Environment for NSG, Allowed environments are dev, test, prod"
  }
}


variable "tags" {
  description = "Specify tags for NSG - max 10"
  type        = map(string)

  validation {
    condition     = length(var.tags) <= 10
    error_message = "Too many tags, max 10 tags are allowed"
  }
}

