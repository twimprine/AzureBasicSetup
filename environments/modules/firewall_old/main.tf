# ------------------------------------------
# Public IP for External Firewall Interface
# ------------------------------------------
resource "azurerm_public_ip" "external_ip" {
  name                = lower(format("%s-external-ip", var.vnet_name))
  location            = var.location
  resource_group_name = var.resource_group
  allocation_method   = "Static"
  tags                = var.tags
}

# ------------------------------------------
# Network Interfaces
# ------------------------------------------

# Internal NIC (Private Subnet)
resource "azurerm_network_interface" "fw-nic-internal" {
  name                  = upper(format("%s-nic", "fw-internal"))
  location              = var.location
  resource_group_name   = var.resource_group
  ip_forwarding_enabled = true

  ip_configuration {
    name                          = var.private_subnet_name
    subnet_id                     = var.private_subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.tags
}

# External NIC (Public Subnet)
resource "azurerm_network_interface" "fw-nic-external" {
  name                = upper(format("%s-nic", "fw-external"))
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = var.external_subnet_name
    subnet_id                     = var.external_subnet_id
    private_ip_address_allocation = "Dynamic"
    primary                       = true
    public_ip_address_id          = azurerm_public_ip.external_ip.id
  }

  tags = var.tags
}

# ------------------------------------------
# Firewall VM (FortiGate)
# ------------------------------------------
resource "azurerm_linux_virtual_machine" "fortigate" {
  name                = "fw-fortigate"
  location            = var.location
  resource_group_name = var.resource_group
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  tags                = var.tags
  network_interface_ids = [
    azurerm_network_interface.fw-nic-internal.id,
    azurerm_network_interface.fw-nic-external.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    name                 = lower(format("%s-os-disk", "fw-fortigate"))
    disk_size_gb         = 75
  }

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = var.fw_version
  }

  disable_password_authentication = false

}

resource "azurerm_managed_disk" "fortigate_data_disk" {
  name                 = lower(format("%s-data-disk", "fw-fortigate"))
  location             = var.location
  resource_group_name  = var.resource_group
  storage_account_type = "Standard_LRS"
  disk_size_gb         = 128
  create_option        = "Empty"
  tags                 = var.tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "fortigate_data_disk_attachment" {
  managed_disk_id    = azurerm_managed_disk.fortigate_data_disk.id
  virtual_machine_id = azurerm_linux_virtual_machine.fortigate.id
  lun                = 0
  caching            = "ReadWrite"
}
# ------------------------------------------
# Network Security Groups (NSG)
# ------------------------------------------

# External Network Security Group
resource "azurerm_network_security_group" "external_nsg" {
  name                = "ExternalNetworkSecurityGroup"
  location            = var.location
  resource_group_name = var.resource_group

  security_rule {
    name                       = "Allow-TCP-All"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = var.tags
}

# Private Network Security Group
resource "azurerm_network_security_group" "private_nsg" {
  name                = "PrivateNetworkSecurityGroup"
  location            = var.location
  resource_group_name = var.resource_group

  security_rule {
    name                       = "Allow-All"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = var.tags
}

# ------------------------------------------
# Network Security Rules (Outbound)
# ------------------------------------------

# External NSG - Allow Outbound Traffic
resource "azurerm_network_security_rule" "outgoing_public" {
  name                        = "egress-external"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group
  network_security_group_name = azurerm_network_security_group.external_nsg.name
}

# Private NSG - Allow Outbound Traffic
resource "azurerm_network_security_rule" "outgoing_private" {
  name                        = "egress-private"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group
  network_security_group_name = azurerm_network_security_group.private_nsg.name
}

# ------------------------------------------
# NSG Associations with Network Interfaces
# ------------------------------------------

# Associate External NSG with External NIC
resource "azurerm_network_interface_security_group_association" "external_port_nsg" {
  depends_on                = [azurerm_network_interface.fw-nic-external]
  network_interface_id      = azurerm_network_interface.fw-nic-external.id
  network_security_group_id = azurerm_network_security_group.external_nsg.id
}

# Associate Private NSG with Internal NIC
resource "azurerm_network_interface_security_group_association" "private_port_nsg" {
  depends_on                = [azurerm_network_interface.fw-nic-internal]
  network_interface_id      = azurerm_network_interface.fw-nic-internal.id
  network_security_group_id = azurerm_network_security_group.private_nsg.id
}
