resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group
}

resource "azurerm_subnet" "private_subnet" {
  name                 = var.private_subnet_name
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [cidrsubnet(var.address_space[0], var.private_subnet_bits, 1)]
}

resource "azurerm_subnet" "external_subnet" {
  name                 = var.external_subnet_name
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [cidrsubnet(var.address_space[0], var.external_subnet_bits, 0)]
}

resource "azurerm_route_table" "private_route_table" {
  name                = "${var.vnet_name}-private-route-table"
  location            = var.location
  resource_group_name = var.resource_group

  route {
    name                   = "default-route"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "fortigate.privateip.address"
  }
}