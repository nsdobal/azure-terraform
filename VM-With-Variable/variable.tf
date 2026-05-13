variable "rg_name"	{ type = string }
variable "rg_location" 	{ type = string }

variable "vm" {
  type = map(object({
    vm_location = string
    vm_size     = string
    vm_priority = string
    os_type 	= string

  }))
}

variable "source_image_reference" {
  type = map (object ({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    }))
}