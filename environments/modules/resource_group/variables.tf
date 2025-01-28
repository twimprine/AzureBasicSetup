variable name {
  description = "The name of the resource group"
  type        = string
}

variable location {
  description = "The location of the resource group"
  type        = string
}

variable tags {
  description = "Tags to apply to the resource group"
  type        = map(string)
}