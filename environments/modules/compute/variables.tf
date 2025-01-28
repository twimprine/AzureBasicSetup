variable "resource_group" {
  description = "The name of the resource group in which the virtual machines should be created"
  type        = string
}

variable location {
  description = "The location in which the virtual machines should be created"
  type        = string
}

variable "base_name" {
  description = "The base name for the virtual machines"
  type        = string
}

variable "vm_count" {
  description = "The number of virtual machines to create"
  type        = number
}

variable "vm_size" {
  description = "The size of the virtual machines to create"
  type        = string
}

variable "admin_username" {
  description = "The username for the virtual machine administrator"
  type        = string
}

variable "admin_password" {
  description = "The password for the virtual machine administrator"
  type        = string
}

variable "tags" {
  description = "A map of tags to apply to the virtual machines"
  type        = map(string)
}