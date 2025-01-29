resource "azurerm_network_interface" "fw-nic-internal" {
  name                = upper(format("%s-nic", "fw-internal"))
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = var.private_subnet_name
    subnet_id                     = var.private_subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.tags
}

resource "azurerm_network_interface" "fw-nic-external" {
  name                = upper(format("%s-nic", "fw-external"))
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = var.external_subnet_name
    subnet_id                     = var.external_subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.tags
}



resource "azurerm_virtual_machine" "fortigate" {
    name                = "fw-fortigate"
    location            = var.location
    resource_group_name = var.resource_group
    network_interface_ids = [
        azurerm_network_interface.fw-nic-internal.id, azurerm_network_interface.fw-nic-external.id
    ]
    vm_size             = "Standard_F4s"
    admin_username      = var.admin_username
    admin_password      = var.admin_password
    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }
    source_image_reference {
        publisher = var.publisher
        offer     = var.offer
        sku       = var.sku
        version   = var.version
    }
}