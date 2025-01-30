# General Configuration
variable "location" {
  description = "The Azure region where the resources should be deployed."
  type        = string
}

variable "resource_group" {
  description = "The name of the resource group where the resources will be created."
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources."
  type        = map(string)
}

# Networking Configuration
variable "external_subnet_name" {
  description = "The name of the external/public subnet."
  type        = string
}

variable "external_subnet_bits" {
  description = "The subnet mask bits for the external/public subnet."
  type        = number
}

variable "private_subnet_name" {
  description = "The name of the private subnet."
  type        = string
}

variable "private_subnet_bits" {
  description = "The subnet mask bits for the private subnet."
  type        = number
}

variable "external_subnet_id" {
  description = "The ID of the external/public subnet."
  type        = string
}

variable "private_subnet_id" {
  description = "The ID of the private subnet."
  type        = string
}

# Virtual Machine Configuration
variable "vm_size" {
  description = "The size of the virtual machine."
  type        = string
}

variable "admin_username" {
  description = "The administrator username for the virtual machine."
  type        = string
}

variable "admin_password" {
  description = "The administrator password for the virtual machine."
  type        = string
}

# Image Configuration
variable "publisher" {
  description = "The publisher of the image."
  type        = string
}

variable "offer" {
  description = "The offer of the image."
  type        = string
}

variable "sku" {
  description = "The SKU of the image."
  type        = string
}

variable "fw_version" {
  description = "The version of the image."
  type        = string
}

variable "vnet_name" {
  description = "The name of the virtual network."
  type        = string
}