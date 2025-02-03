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