resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group
  tags                = var.tags
}

resource "azurerm_subnet" "private_subnet" {
  name                 = var.private_subnet_name
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [cidrsubnet(var.address_space[0], var.private_subnet_bits, 1)]
  # tags                 = var.tags
}

resource "azurerm_subnet" "external_subnet" {
  name                 = var.external_subnet_name
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [cidrsubnet(var.address_space[0], var.external_subnet_bits, 0)]
  # tags                 = var.tags
}

resource "azurerm_route_table" "private_route_table" {
  name                = "${var.vnet_name}-private-route-table"
  location            = var.location
  resource_group_name = var.resource_group
}

resource "azurerm_route" "default" {
    name                   = "default-route"
    route_table_name = azurerm_route_table.private_route_table.name
    resource_group_name    = var.resource_group
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = var.fw_private_ip_address
    # tags = var.tags
}

resource "azurerm_subnet_route_table_association" "private_subnet_association" {
  subnet_id      = azurerm_subnet.private_subnet.id
  route_table_id = azurerm_route_table.private_route_table.id
}


