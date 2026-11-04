variable "subscription_id" {
  description = "Azure subscription ID used by this environment."
  type        = string
  default     = null
}

variable "location" {
  description = "Azure region for the QA environment."
  type        = string
  default     = "centralindia"
}

variable "resource_group_name" {
  description = "Name of the QA resource group."
  type        = string
  default     = "rg-enterprise-observability-qa"
}

variable "vnet_name" {
  description = "Name of the QA virtual network."
  type        = string
  default     = "vnet-observability-qa"
}

variable "vnet_address_space" {
  description = "Address space assigned to the QA virtual network."
  type        = list(string)
  default     = ["10.40.0.0/16"]
}

variable "subnet_name" {
  description = "Name of the QA subnet."
  type        = string
  default     = "snet-observability-qa"
}

variable "subnet_address_prefixes" {
  description = "Address prefixes assigned to the QA subnet."
  type        = list(string)
  default     = ["10.40.1.0/24"]
}

variable "nsg_name" {
  description = "Name of the QA network security group."
  type        = string
  default     = "nsg-observability-qa"
}

variable "common_tags" {
  description = "Tags applied to QA resources."
  type        = map(string)
  default = {
    project     = "enterprise-observability-platform"
    environment = "qa"
    managed_by  = "terraform"
  }
}
