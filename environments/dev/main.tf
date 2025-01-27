resource "azurerm_resource_group" "resource-group" {
  name     = var.resource_group.name
  location = var.resource_group.location
}

module "network" {
  source           = "../../modules/network"
  resource_group   = azurerm_resource_group.resource-group.name
  location         = var.resource_group.location
  vnet_name        = "vnet-dev"
  address_space    = ["10.254.0.0/16"]
}

module "domain_controller" {
  source           = "../../modules/compute"
  resource_group   = azurerm_resource_group.resource-group.name
  location         = var.resource_group.location
  vm_count         = 2
  vm_size          = "Standard_B2s"
  admin_username   = "itc-admin"
  admin_password   = var.admin_password
}

module "fileserver" {
  source           = "../../modules/compute"
  resource_group   = azurerm_resource_group.resource-group.name
  location         = var.resource_group.location
  vm_count         = 1
  vm_size          = "Standard_B2s"
  admin_username   = "itc-admin"
  admin_password   = var.admin_password
}