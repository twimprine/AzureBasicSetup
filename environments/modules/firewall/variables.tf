variable tags {
  description = "Tags to apply to the resource group"
  type        = map(string)
}

variable "location" {
  description = "The Azure region where the resource group should be created"
  type        = string
}

variable "resource_group" {
  description = "The name of the resource group in which the virtual network should be created"
  type        = string
}

variable "external_subnet_name" {
  description = "The name of the subnet"
  type        = string
}

variable "external_subnet_bits" {
  description = "The address prefix that is used by the subnet"
  type        = number
}

variable "private_subnet_name" {
  description = "The name of the subnet"
  type        = string
}

variable "private_subnet_bits" {
  description = "The address prefix that is used by the subnet"
  type        = number
}

variable "private_subnet_id" {
  description = "The ID of the private subnet"
  type        = string
}

variable "external_subnet_id" {
  description = "The ID of the public subnet"
  type        = string
}

variable "vm_size" {
  description = "The size of the VM"
  type        = string
}

variable "admin_username" {
  description = "The admin username for the VM"
  type        = string
}

variable "admin_password" {
  description = "The admin password for the VM"
  type        = string
}

variable "publisher" {
  description = "The publisher of the image"
  type        = string
}

variable "offer" {
  description = "The offer of the image"
  type        = string
}

variable "sku" {
  description = "The SKU of the image"
  type        = string
}

variable "version" {
  description = "The version of the image"
  type        = string
}