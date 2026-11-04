variable "subscription_id" {
  description = "Azure subscription ID used by this environment."
  type        = string
  default     = null
}

variable "location" {
  description = "Azure region for the test environment."
  type        = string
  default     = "centralindia"
}

variable "resource_group_name" {
  description = "Name of the test resource group."
  type        = string
  default     = "rg-enterprise-observability-test"
}

variable "vnet_name" {
  description = "Name of the test virtual network."
  type        = string
  default     = "vnet-observability-test"
}

variable "vnet_address_space" {
  description = "Address space assigned to the test virtual network."
  type        = list(string)
  default     = ["10.30.0.0/16"]
}

variable "subnet_name" {
  description = "Name of the test subnet."
  type        = string
  default     = "snet-observability-test"
}

variable "subnet_address_prefixes" {
  description = "Address prefixes assigned to the test subnet."
  type        = list(string)
  default     = ["10.30.1.0/24"]
}

variable "nsg_name" {
  description = "Name of the test network security group."
  type        = string
  default     = "nsg-observability-test"
}

variable "common_tags" {
  description = "Tags applied to test resources."
  type        = map(string)
  default = {
    project     = "enterprise-observability-platform"
    environment = "test"
    managed_by  = "terraform"
  }
}
