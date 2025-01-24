module "network" {
  source           = "../../modules/network"
  resource_group   = "rg-dev"
  location         = "East US"
  vnet_name        = "vnet-dev"
  address_space    = ["10.250.0.0/16"]
}

module "compute" {
  source           = "../../modules/compute"
  resource_group   = "rg-dev"
  location         = "East US"
  vm_count         = 2
  vm_size          = "Standard_B2s"
  admin_username   = "itc-admin"
  admin_password   = var.admin_password
}
