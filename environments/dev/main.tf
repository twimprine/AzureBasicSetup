
module "resource_group" {
  source   = "../modules/resource_group"
  name     = lower(format("%s-dev", var.resource_group.name))
  location = var.resource_group.location
  tags     = var.tags
}

module "network" {
  source               = "../modules/network"
  resource_group       = module.resource_group.name
  location             = var.resource_group.location
  vnet_name            = var.virtual_network.dev.name
  address_space        = var.virtual_network.dev.address_space
  private_subnet_name  = var.virtual_network.private_subnet.name
  private_subnet_bits  = var.virtual_network.private_subnet.subnet_bits
  external_subnet_name = var.virtual_network.external_subnet.name
  external_subnet_bits = var.virtual_network.external_subnet.subnet_bits
  tags                 = var.tags
}

module "domain_controller" {
  source         = "../modules/compute"
  resource_group = module.resource_group.name
  location       = var.resource_group.location
  base_name      = var.virtual_machines.dc.base_name
  vm_count       = var.virtual_machines.dc.count
  vm_size        = var.virtual_machines.dc.size
  admin_username = var.virtual_machines.admin_username
  admin_password = var.virtual_machines.admin_password
  subnet_id      = module.network.private_subnet_id
  subnet_name    = module.network.private_subnet_name
  os_version     = var.virtual_machines.os_version
  tags           = var.tags
}

module "fileserver" {
  source         = "../modules/compute"
  resource_group = module.resource_group.name
  location       = var.resource_group.location
  base_name      = var.virtual_machines.fileserver.base_name
  vm_count       = var.virtual_machines.fileserver.count
  vm_size        = var.virtual_machines.fileserver.size
  admin_username = var.virtual_machines.admin_username
  admin_password = var.virtual_machines.admin_password
  subnet_id      = module.network.private_subnet_id
  subnet_name    = module.network.private_subnet_name
  os_version     = var.virtual_machines.os_version
  tags           = var.tags
}
