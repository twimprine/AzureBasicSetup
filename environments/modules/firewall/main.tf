resource "azurerm_firewall" "main" {
  name                = "azfw-main"
  location            = var.location
  resource_group_name = var.resource_group
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"

  ip_configuration {
    name                 = "firewall-ip-config"
    subnet_id            = azurerm_subnet.firewall_subnet.id
    public_ip_address_id = azurerm_public_ip.firewall_pip.id
  }

  tags = var.tags
}

# Public IP for Azure Firewall
resource "azurerm_public_ip" "firewall_pip" {
  name                = "firewall-public-ip"
  location            = var.location
  resource_group_name = var.resource_group
  allocation_method   = "Static"
  sku                 = "Standard"
}

# AzureFirewallSubnet (Required)
# See README for more information on network allocation
resource "azurerm_subnet" "firewall_subnet" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = var.resource_group
  virtual_network_name = var.vnet_name
  address_prefixes     = [cidrsubnet(var.address_space[0], 8, 0)]
}