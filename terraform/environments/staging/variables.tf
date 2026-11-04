variable "subscription_id" {
  description = "Azure subscription ID used by this environment."
  type        = string
  default     = null
}

variable "location" {
  description = "Azure region for the STAGING environment."
  type        = string
  default     = "centralindia"
}

variable "resource_group_name" {
  description = "Name of the STAGING resource group."
  type        = string
  default     = "rg-enterprise-observability-staging"
}

variable "vnet_name" {
  description = "Name of the STAGING virtual network."
  type        = string
  default     = "vnet-observability-staging"
}

variable "vnet_address_space" {
  description = "Address space assigned to the STAGING virtual network."
  type        = list(string)
  default     = ["10.50.0.0/16"]
}

variable "subnet_name" {
  description = "Name of the STAGING subnet."
  type        = string
  default     = "snet-observability-staging"
}

variable "subnet_address_prefixes" {
  description = "Address prefixes assigned to the STAGING subnet."
  type        = list(string)
  default     = ["10.50.1.0/24"]
}

variable "nsg_name" {
  description = "Name of the STAGING network security group."
  type        = string
  default     = "nsg-observability-staging"
}

variable "common_tags" {
  description = "Tags applied to STAGING resources."
  type        = map(string)
  default = {
    project     = "enterprise-observability-platform"
    environment = "staging"
    managed_by  = "terraform"
  }
}
