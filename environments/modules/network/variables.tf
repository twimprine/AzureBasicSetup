variable "vnet_name" {
  description = "The name of the network"
  type        = string
}

variable "address_space" {
  description = "The address space that is used by the virtual network"
  type        = list(string)
}

variable "location" {
  description = "The Azure region where the virtual network should be created"
  type        = string
}

variable "resource_group" {
  description = "The name of the resource group in which the virtual network should be created"
  type        = string
}
variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
}

variable "subnet_bits" {
  description = "The address prefix that is used by the subnet"
  type        = number
}

variable tags {
  description = "Tags to apply to the resource group"
  type        = map(string)
}