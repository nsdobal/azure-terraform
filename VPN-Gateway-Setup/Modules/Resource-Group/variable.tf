variable "name" {
  description = "Name of the Resource Group"
  type        = string

  validation {
    condition     = length(var.name) > 0
    error_message = "Resource Group name cannot be empty"
  }
}


variable "location" {
  description = "Give the Region, where the RG will be created"
  type        = string

  validation {
    condition     = contains(["centralindia", "eastus", "westus2", "sounthasia"], lower(var.location))
    error_message = "location is not allowed, Please select from centralindia, eastus, westus2, southasia"
  }
}

variable "environment" {
  description = "Mention Environment - Dev, Test, Prod"
  type        = string

  validation {
    condition     = contains(["dev", "test", "prod"], lower(var.environment))
    error_message = "Environment can be dev, test or prod"
  }
}

variable "tags" {
  description = "Tags to apply with RG, max 10 tags"
  type        = map(string)

  validation {
    condition     = length(var.tags) <= 10
    error_message = "Too many tags, Maximum 10 tags are allowed."
  }
}