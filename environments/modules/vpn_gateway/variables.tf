variable "resource_group" {
  description = "The name of the resource group in which the VPN Gateway will be created."
  type        = string
}

variable "location" {
  description = "The Azure region in which the VPN Gateway will be created."
  type        = string
}   

variable "tags" {
  description = "A map of tags to apply to the VPN Gateway resources."
  type        = map(string)
}

variable "address_space" {
  description = "The address space that the VPN Gateway will use."
  type        = list(string)
}