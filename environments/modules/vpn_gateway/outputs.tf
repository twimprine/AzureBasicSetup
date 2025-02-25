# ------------------------------------------
# 🔹 Virtual Network & Subnet Information
# ------------------------------------------
output "vpn_gateway_subnet_id" {
  description = "The ID of the subnet where the VPN Gateway is deployed."
  value       = azurerm_subnet.gateway_subnet.id
}

output "vpn_azure_network" {
  description = "The Azure Virtual Network address space used for the VPN connection."
  value       = var.address_space
}

# ------------------------------------------
# 🔹 VPN Gateway Information
# ------------------------------------------
output "vpn_gateway_public_ip" {
  description = "Public IP address of the Azure VPN Gateway."
  value       = azurerm_public_ip.vpn_gw_pip.ip_address
}

output "vpn_gateway_id" {
  description = "The ID of the Azure Virtual Network Gateway."
  value       = azurerm_virtual_network_gateway.vpn_gw.id
}

# ------------------------------------------
# 🔹 Site-to-Site VPN Connection Details
# ------------------------------------------
output "vpn_remote_network" {
  description = "The remote network address space configured for the VPN connection."
  value       = var.vpn.location.address_space
}

output "vpn_remote_gateway_ip" {
  description = "The remote VPN gateway public IP."
  value       = var.vpn.location.gateway_address
}

output "vpn_connection_id" {
  description = "The VPN connection ID."
  value       = azurerm_virtual_network_gateway_connection.vpn_connection["default"].id
}

# ------------------------------------------
# 🔹 Security & Shared Key
# ------------------------------------------
output "vpn_shared_key" {
  description = "The pre-shared key (PSK) for the VPN connection."
  value       = var.vpn.location.shared_key
  sensitive   = true
}
