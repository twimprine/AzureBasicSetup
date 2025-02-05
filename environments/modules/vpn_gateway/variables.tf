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

variable "vnet_name" {
  description = "The name of the virtual network."
  type        = string
}

variable "env" {
  description = "The current operating environment dev/prod"
  type        = string
}

variable "location_name" {
  description = "The name of the location in which the VPN will terminate."
  type        = string
}

variable "location_gateway" {
  description = "The public IP address of the VPN Gateway at the location."
  type        = string
}

variable "location_address_space" {
  description = "The address space that the VPN Gateway will use at the location."
  type        = list(string)
}

variable "shared_key" {
  description = "The shared key for the VPN connection."
  type        = string
}