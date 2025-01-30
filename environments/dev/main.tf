
locals {
  # This block is to allow for easy changes from dev / prod
  vnet_name     = var.virtual_network.dev.name
  address_space = var.virtual_network.dev.address_space
  env           = "dev"
}

module "resource_group" {
  source   = "../modules/resource_group"
  name     = lower(format("%s-%s", var.resource_group.name, local.env))
  location = var.resource_group.location
  tags     = var.tags
}

module "network" {
  source                = "../modules/network"
  resource_group        = module.resource_group.name
  location              = var.resource_group.location
  vnet_name             = local.vnet_name
  address_space         = local.address_space
  private_subnet_name   = var.virtual_network.private_subnet.name
  private_subnet_bits   = var.virtual_network.private_subnet.subnet_bits
  external_subnet_name  = var.virtual_network.external_subnet.name
  external_subnet_bits  = var.virtual_network.external_subnet.subnet_bits
  tags                  = var.tags
  fw_private_ip_address = module.firewall.fw_private_ip_address
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
  os_disk_size   = var.virtual_machines.dc.os_disk.size
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
  os_disk_size   = var.virtual_machines.fileserver.os_disk.size
  tags           = var.tags
}

module "firewall" {
  source               = "../modules/firewall"
  location             = var.resource_group.location
  resource_group       = module.resource_group.name
  tags                 = var.tags
  external_subnet_id   = module.network.external_subnet_id
  external_subnet_name = module.network.external_subnet_name
  external_subnet_bits = var.virtual_network.external_subnet.subnet_bits
  private_subnet_id    = module.network.private_subnet_id
  private_subnet_name  = module.network.private_subnet_name
  private_subnet_bits  = var.virtual_network.private_subnet.subnet_bits
  vm_size              = var.firewall.vm_size
  admin_username       = var.firewall.admin_username
  admin_password       = var.firewall.admin_password
  publisher            = var.firewall.image.publisher
  offer                = var.firewall.image.offer
  sku                  = var.firewall.image.sku
  fw_version           = var.firewall.image.version
  vnet_name            = local.vnet_name
}
