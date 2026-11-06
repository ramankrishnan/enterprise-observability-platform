# DEV environment root module.

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

module "monitoring_network" {
  source = "../../modules/monitoring-network"

  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  vnet_name           = module.networking.virtual_network_name

  subnet_name             = var.monitoring_subnet_name
  subnet_address_prefixes = var.monitoring_subnet_address_prefixes
  nsg_name                = var.monitoring_nsg_name
  admin_ssh_cidr          = var.admin_ssh_cidr

  tags = var.common_tags
}

module "monitoring_vm" {
  source = "../../modules/linux-vm"

  resource_group_name = module.resource_group.name
  location            = module.resource_group.location

  vm_name        = var.monitoring_vm_name
  vm_size        = var.monitoring_vm_size
  admin_username = var.monitoring_admin_username
  ssh_public_key = var.monitoring_ssh_public_key

  subnet_id = module.monitoring_network.subnet_id

  tags = var.common_tags
}
