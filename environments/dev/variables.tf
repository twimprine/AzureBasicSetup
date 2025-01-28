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
      address_space = string
    })
    prod = object({
      name          = string
      address_space = string
    })
  })
  description = "Configuration for virtual networks in dev and prod environments."
}

# Virtual Machines
variable "virtual_machines" {
  type = object({
    admin_username = string
    admin_password = string
    dc = object({
      base_name = string
      size      = string
      count     = number
      os_disk = object({
        size                  = number
        caching               = string
        storage_account_type  = string
      })
    })
    fileserver = object({
      base_name = string
      size      = string
      count     = number
      os_disk = object({
        size                  = number
        caching               = string
        storage_account_type  = string
      })
      data_disk = object({
        size                  = number
        caching               = string
        storage_account_type  = string
      })
    })
  })
  description = "Configuration for virtual machines, including domain controllers and file servers."
}

# Tags
variable "tags" {
  type = map(string)
  description = "Tags to apply to all resources."
}
