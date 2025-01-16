terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "terraformstate"
    container_name       = "statefiles"
    key                  = "terraform.tfstate"
  }
}
