variable "rgs" {
  default = ["rg-a", "rg-b", "rg-c"]
}


resource "azurerm_resource_group" "rg1" {

  count = length(var.rgs)

  name     = count.index
  location = "centralindia"
}
