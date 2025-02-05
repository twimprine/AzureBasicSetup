output "azurerm_gateway_subnet_id" {
  description = "The ID of the subnet that the VPN Gateway is connected to."
  value       = azurerm_subnet.gateway_subnet.id
}