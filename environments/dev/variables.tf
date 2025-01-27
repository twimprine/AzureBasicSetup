
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

# Tags
variable "tags" {
  type = map(string)
  description = "Tags to apply to all resources."
}
