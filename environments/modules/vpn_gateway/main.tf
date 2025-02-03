# Public IP for VPN Gateway
resource "azurerm_public_ip" "vpn_gw_pip" {
  name                = "vpn-gw-public-ip"
  location            = var.location
  resource_group_name = var.resource_group
  allocation_method   = "Dynamic"
}

# Virtual Network Gateway (VPN Gateway)
resource "azurerm_virtual_network_gateway" "vpn_gw" {
  name                = "vpn-gateway"
  location            = var.location
  resource_group_name = var.resource_group
  type                = "Vpn"
  vpn_type            = "RouteBased"
  active_active       = false
  enable_bgp          = false
  sku                 = "VpnGw2"

  ip_configuration {
    name                          = "vpn-gateway-config"
    public_ip_address_id          = azurerm_public_ip.vpn_gw_pip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.gateway_subnet.id
  }

  tags = var.tags
}

# Gateway Subnet (Required)
resource "azurerm_subnet" "gateway_subnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [cidrsubnet(var.address_space[0], 8, 3)]
}
