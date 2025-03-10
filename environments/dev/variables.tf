# Auth Variables
# Azure Authentication Variables
variable "client_id" {
  type        = string
  description = "The client ID of the Service Principal used for authentication."
}

variable "client_secret" {
  type        = string
  description = "The client secret of the Service Principal used for authentication."
}

variable "tenant_id" {
  type        = string
  description = "The Azure tenant ID."
}

variable "subscription_id" {
  type        = string
  description = "The Azure subscription ID."
}



# Resource Group
variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
  description = "Configuration for the Azure resource group."
}

# Virtual Network
variable "virtual_network" {
  type = object({
    dev = object({
      name          = string
      address_space = list(string)
    })
    prod = object({
      name          = string
      address_space = list(string)
    })
    private_subnet = object({
      name        = string
      subnet_bits = string
    })
    external_subnet = object({
      name        = string
      subnet_bits = string
    })

  })
  description = "Configuration for virtual networks in dev and prod environments."
}

# Virtual Machines
variable "virtual_machines" {
  type = object({
    admin_username = string
    admin_password = string
    os_version = string
    dc = object({
      base_name = string
      size      = string
      count     = number
      os_disk = object({
        size                 = number
        caching              = string
        storage_account_type = string
      })
      user_data_script = string
    })
    fileserver = object({
      base_name = string
      size      = string
      count     = number
      os_disk = object({
        size                 = number
        caching              = string
        storage_account_type = string
      })
      data_disk = object({
        size                 = number
        caching              = string
        storage_account_type = string
      })
      user_data_script = string
    })
  })
  description = "Configuration for virtual machines, including domain controllers and file servers."
}

# Tags
variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources."
}

variable "firewall" {
  description = "Configuration for the firewall virtual machine."

  type = object({
    vm_size        = string
    admin_username = string
    admin_password = string
    license        = string

    image = object({
      offer     = string
      publisher = string
      sku       = string
      version   = string
      urn       = string
    })
    os_disk = object({
      caching              = string
      storage_account_type = string
      size                 = number
    })
  })
}

variable "vpn" {
  description = "Configuration for the VPN connection"
  type = object({
    location = object({
      name            = string
      address_space   = list(string) # List of CIDR blocks
      gateway_address = string       # Public IP of on-prem VPN gateway
      shared_key      = string       # Pre-shared key for VPN connection
    })
  })
}
