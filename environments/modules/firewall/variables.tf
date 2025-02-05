variable "location" {
  description = "The Azure region in which all resources will be created."
  type        = string
}

variable "resource_group" {
  description = "The name of the resource group in which all resources will be created."
  type        = string
}

variable "tags" {
  description = "A map of tags to apply to all resources."
  type        = map(string)
}

variable "vnet_name" {
  description = "The name of the virtual network."
  type        = string
}

variable "address_space" {
  description = "The address space that the VPN Gateway will use."
  type        = list(string)
}

variable "env" {
  description = "The current operating environment dev/prod"
  type        = string
}

variable "azure_gateway_subnet_id" {
  description = "The ID of the subnet to which the VPN Gateway will be connected."
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
