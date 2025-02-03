output "virtual_network_id" {
  value = azurerm_virtual_network.vnet.id
}

output "virtual_network_name" {
  value = azurerm_virtual_network.vnet.name
}

output "virtual_network_address_space" {
  value = azurerm_virtual_network.vnet.address_space
}

output "private_subnet_id" {
  value = azurerm_subnet.private_subnet.id
}

# output "external_subnet_id" {
#   value = azurerm_subnet.external_subnet.id
# }

output "private_subnet_name" {
  value = azurerm_subnet.private_subnet.name
}

# output "external_subnet_name" {
#   value = azurerm_subnet.external_subnet.name
# }