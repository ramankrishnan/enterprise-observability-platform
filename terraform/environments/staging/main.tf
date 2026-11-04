# STAGING environment root module.

module "resource_group" {
  source = "../../modules/resource-group"

  name     = var.resource_group_name
  location = var.location
  tags     = var.common_tags
}

module "networking" {
  source = "../../modules/networking"

  resource_group_name     = module.resource_group.name
  location                = module.resource_group.location
  vnet_name               = var.vnet_name
  vnet_address_space      = var.vnet_address_space
  subnet_name             = var.subnet_name
  subnet_address_prefixes = var.subnet_address_prefixes
  nsg_name                = var.nsg_name
  tags                    = var.common_tags
}
