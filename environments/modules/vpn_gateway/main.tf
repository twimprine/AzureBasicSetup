# Public IP for VPN Gateway
resource "azurerm_public_ip" "vpn_gw_pip" {
  name                = lower(format("vpn-gw-public-ip-%s", var.env))
  location            = var.location
  resource_group_name = var.resource_group
  allocation_method   = "Static"
  tags                = var.tags
  sku                 = "Standard"
}

# Virtual Network Gateway (VPN Gateway)
resource "azurerm_virtual_network_gateway" "vpn_gw" {
  name                = lower(format("vpn-gateway-%s", var.env))
  location            = var.location
  resource_group_name = var.resource_group
  type                = "Vpn"
  vpn_type            = "RouteBased"
  active_active       = false
  enable_bgp          = false
  sku                 = "VpnGw2"
  tags                = var.tags

  ip_configuration {
    name                          = lower(format("vpn-gateway-config-%s", var.env))
    public_ip_address_id          = azurerm_public_ip.vpn_gw_pip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.gateway_subnet.id
  }
}

# Gateway Subnet (Required)
resource "azurerm_subnet" "gateway_subnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = var.resource_group
  virtual_network_name = var.vnet_name
  address_prefixes     = [cidrsubnet(var.address_space[0], 8, 3)]
}


####################################################################################################
# Remote Site Configurations
####################################################################################################
# Local Network Gateway (On-Prem)
resource "azurerm_local_network_gateway" "on_prem" {
  for_each = { "default" = var.vpn.location }

  name                = lower(format("%s-on-premises-lgw", replace(each.value.name, " ", "-")))
  location            = var.location
  resource_group_name = var.resource_group
  gateway_address     = var.location_gateway

  address_space = var.location_address_space
}

# Site-to-Site VPN Connection
resource "azurerm_virtual_network_gateway_connection" "vpn_connection" {
  for_each = { "default" = var.vpn.location }

  name                = lower(format("%s-vpn-to-onprem", replace(each.value.name, " ", "-")))
  location            = var.location
  resource_group_name = var.resource_group

  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.vpn_gw.id
  local_network_gateway_id   = azurerm_local_network_gateway.on_prem[each.key].id

  shared_key = var.shared_key

  ipsec_policy {
    dh_group         = "DHGroup14"
    ike_encryption   = "AES256"
    ike_integrity    = "SHA256"
    ipsec_encryption = "AES256"
    ipsec_integrity  = "SHA256"
    pfs_group        = "PFS14"
    sa_lifetime      = 28800
  }

  tags = var.tags
}
