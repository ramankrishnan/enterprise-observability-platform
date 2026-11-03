variable "subscription_id" {
  description = "Azure subscription ID used by this environment."
  type        = string
  default     = null
}

variable "location" {
  description = "Azure region for the development environment."
  type        = string
  default     = "centralindia"
}

variable "resource_group_name" {
  description = "Name of the development resource group."
  type        = string
  default     = "rg-enterprise-observability-dev"
}

variable "vnet_name" {
  description = "Name of the development virtual network."
  type        = string
  default     = "vnet-observability-dev"
}

variable "vnet_address_space" {
  description = "Address space assigned to the development virtual network."
  type        = list(string)
  default     = ["10.20.0.0/16"]
}

variable "subnet_name" {
  description = "Name of the development subnet."
  type        = string
  default     = "snet-observability-dev"
}

variable "subnet_address_prefixes" {
  description = "Address prefixes assigned to the development subnet."
  type        = list(string)
  default     = ["10.20.1.0/24"]
}

variable "nsg_name" {
  description = "Name of the development network security group."
  type        = string
  default     = "nsg-observability-dev"
}

variable "common_tags" {
  description = "Tags applied to development resources."
  type        = map(string)
  default = {
    project     = "enterprise-observability-platform"
    environment = "dev"
    managed_by  = "terraform"
  }
}
