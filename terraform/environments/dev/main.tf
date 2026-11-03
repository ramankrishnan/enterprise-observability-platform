# Development environment infrastructure.

resource "azurerm_resource_group" "dev" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.common_tags
}

resource "azurerm_virtual_network" "dev" {
  name                = var.vnet_name
  location            = azurerm_resource_group.dev.location
  resource_group_name = azurerm_resource_group.dev.name
  address_space       = var.vnet_address_space
  tags                = var.common_tags
}

resource "azurerm_subnet" "dev" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.dev.name
  virtual_network_name = azurerm_virtual_network.dev.name
  address_prefixes     = var.subnet_address_prefixes
}

resource "azurerm_network_security_group" "dev" {
  name                = var.nsg_name
  location            = azurerm_resource_group.dev.location
  resource_group_name = azurerm_resource_group.dev.name
  tags                = var.common_tags
}

resource "azurerm_subnet_network_security_group_association" "dev" {
  subnet_id                 = azurerm_subnet.dev.id
  network_security_group_id = azurerm_network_security_group.dev.id
}
