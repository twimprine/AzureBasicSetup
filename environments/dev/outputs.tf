output "VPN_SharedKey" {
  description = "The pre-shared key for the VPN connection"
  value       = module.vpn_gateway.vpn_shared_key
  sensitive   = true
}

output "VPN_GatewayIP" {
    description = "Public IP address of the Azure VPN Gateway"
    value       = module.vpn_gateway.vpn_gateway_public_ip
}

output "AzureNetworks" {
    description = "The Azure network address space for VPN connection"
    value       = module.vpn_gateway.vpn_azure_network
}