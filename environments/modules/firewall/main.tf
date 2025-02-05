resource "azurerm_firewall" "main" {
  name                = lower(format("azfw-main-%s", var.env))
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
  name                = lower(format("firewall-public-ip-%s", var.env))
  location            = var.location
  resource_group_name = var.resource_group
  allocation_method   = "Static"
  sku                 = "Standard"
}

# AzureFirewallSubnet (Required) - It requires this name to be AzureFirewallSubnet
# See README for more information on network allocation
resource "azurerm_subnet" "firewall_subnet" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = var.resource_group
  virtual_network_name = var.vnet_name
  address_prefixes     = [cidrsubnet(var.address_space[0], 8, 0)]
}

resource "azurerm_route_table" "firewall-route" {
  name                = lower(format("rt-firewall-%s", var.env))
  resource_group_name = var.resource_group
  location            = var.location

  route {
    name                   = lower(format("%s-default-route", var.env))
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.main.ip_configuration[0].private_ip_address
  }

  tags = var.tags
}

resource "azurerm_subnet_route_table_association" "firewall-rt-assoc" {
  subnet_id      = var.azure_gateway_subnet_id
  route_table_id = azurerm_route_table.firewall-route.id
}


resource "azurerm_firewall_network_rule_collection" "vpn_rules" {
  name                = lower(format("vpn-rules-%s-%s", var.env, replace(var.location_name, " ", "-")))
  azure_firewall_name = azurerm_firewall.main.name
  resource_group_name = var.resource_group
  priority            = 100
  action              = "Allow"

  rule {
    name = "allow-vpn"
    protocols = ["UDP"]
    source_addresses = [var.location_gateway]  # On-premises VPN Public IP
    destination_ports = ["500", "4500"]  # IPsec Ports
    destination_addresses = ["*"]
  }
}

resource "azurerm_network_security_group" "vpn_nsg" {
  name                = lower(format("vpn-nsg-%s-%s", var.env, replace(var.location_name, " ", "-")))
  location            = var.location
  resource_group_name = var.resource_group

  security_rule {
    name                       = format("Allow-VPN-Traffic-%s-%s", var.env, replace(var.location_name, " ", "-"))
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "500-4500"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = var.tags
}

# Associate NSG with VPN Gateway Subnet
resource "azurerm_subnet_network_security_group_association" "vpn_nsg_assoc" {
  subnet_id                 = var.azure_gateway_subnet_id
  network_security_group_id = azurerm_network_security_group.vpn_nsg.id
}
