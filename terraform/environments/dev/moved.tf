moved {
  from = azurerm_resource_group.dev
  to   = module.resource_group.azurerm_resource_group.this
}

moved {
  from = azurerm_virtual_network.dev
  to   = module.networking.azurerm_virtual_network.this
}

moved {
  from = azurerm_subnet.dev
  to   = module.networking.azurerm_subnet.this
}

moved {
  from = azurerm_network_security_group.dev
  to   = module.networking.azurerm_network_security_group.this
}

moved {
  from = azurerm_subnet_network_security_group_association.dev
  to   = module.networking.azurerm_subnet_network_security_group_association.this
}
