output "virtual_network_name" {
  description = "Name of the virtual network."
  value       = azurerm_virtual_network.this.name
}

output "virtual_network_address_space" {
  description = "Address space of the virtual network."
  value       = azurerm_virtual_network.this.address_space
}

output "subnet_name" {
  description = "Name of the subnet."
  value       = azurerm_subnet.this.name
}

output "subnet_address_prefixes" {
  description = "Address prefixes of the subnet."
  value       = azurerm_subnet.this.address_prefixes
}

output "network_security_group_name" {
  description = "Name of the network security group."
  value       = azurerm_network_security_group.this.name
}

output "network_security_group_id" {
  description = "Resource ID of the network security group."
  value       = azurerm_network_security_group.this.id
}
