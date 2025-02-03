output "fw_private_ip_address" {
  value = azurerm_network_interface.fw-nic-internal.private_ip_address
}