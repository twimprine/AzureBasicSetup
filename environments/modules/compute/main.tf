data "azurerm_platform_image" "windows_server" {
  location  = var.location
  publisher = "MicrosoftWindowsServer"
  offer     = "WindowsServer"
  sku       = format("%s-datacenter-smalldisk-g2", var.os_version)
  # sku = "2022-datacenter"
  # version = "latest"
}

resource "azurerm_network_interface" "vm-nic" {
  count               = var.vm_count
  name                = upper(format("%s-nic-%02d", var.base_name, count.index + 1))
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = var.subnet_name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.tags
}


resource "azurerm_windows_virtual_machine" "win-vm" {
  count               = var.vm_count
  name                = upper(format("%s-%02d", var.base_name, count.index + 1))
  resource_group_name = var.resource_group
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [
    azurerm_network_interface.vm-nic[count.index].id,
  ]

  enable_automatic_updates = true
  provision_vm_agent       = true
  tags                     = var.tags

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = var.os_disk_size

  }

  source_image_reference {
    publisher = data.azurerm_platform_image.windows_server.publisher
    offer     = data.azurerm_platform_image.windows_server.offer
    sku       = data.azurerm_platform_image.windows_server.sku
    version   = data.azurerm_platform_image.windows_server.version
  }
}
