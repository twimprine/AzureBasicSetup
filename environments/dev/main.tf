resource "azurerm_resource_group" "resource-group" {
  name     = var.resource_group.name
  location = var.resource_group.location
}

module "network" {
  source           = "../modules/network"
  resource_group   = azurerm_resource_group.resource-group.name
  location         = var.resource_group.location
  vnet_name        = var.virtual_network.dev.name
  address_space    = var.virtual_network.dev.address_space
}

module "domain_controller" {
  source           = "../modules/compute"
  resource_group   = azurerm_resource_group.resource-group.name
  location         = var.resource_group.location
  base_name        = var.virtual_machines.dc.base_name
  vm_count         = var.virtual_machines.dc.count
  vm_size          = var.virtual_machines.dc.size
  admin_username   = var.virtual_machines.admin_username
  admin_password   = var.virtual_machines.admin_password
}

module "fileserver" {
  source           = "../modules/compute"
  resource_group   = azurerm_resource_group.resource-group.name
  location         = var.resource_group.location
  vm_count         = var.virtual_machines.fileserver.count
  vm_size          = var.virtual_machines.fileserver.size
  admin_username   = var.virtual_machines.admin_username
  admin_password   = var.virtual_machines.admin_password
}