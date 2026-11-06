variable "resource_group_name" {
  description = "Existing DEV resource group."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "vnet_name" {
  description = "Existing DEV virtual network."
  type        = string
}

variable "subnet_name" {
  description = "Dedicated monitoring subnet name."
  type        = string
}

variable "subnet_address_prefixes" {
  description = "Monitoring subnet address prefixes."
  type        = list(string)
}

variable "nsg_name" {
  description = "Dedicated monitoring NSG name."
  type        = string
}

variable "admin_ssh_cidr" {
  description = "Administrator public IPv4 CIDR allowed to SSH."
  type        = string

  validation {
    condition     = can(cidrnetmask(var.admin_ssh_cidr))
    error_message = "Provide a valid IPv4 CIDR, such as 203.0.113.10/32."
  }
}

variable "tags" {
  description = "Tags applied to monitoring network resources."
  type        = map(string)
}
