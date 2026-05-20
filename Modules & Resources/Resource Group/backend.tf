terraform {
  backend "azurerm" {
    resource_group_name  = "nd-rg-tfstate"
    storage_account_name = "ndstorageaccounttfstate1"
    container_name       = "nd-tfstate"
    key                  = "test.tfstate"
  }
}