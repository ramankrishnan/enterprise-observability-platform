output "subnet_id" {
  description = "Monitoring subnet resource ID."
  value       = azurerm_subnet.this.id
}

output "subnet_name" {
  description = "Monitoring subnet name."
  value       = azurerm_subnet.this.name
}

output "subnet_address_prefixes" {
  description = "Monitoring subnet address prefixes."
  value       = azurerm_subnet.this.address_prefixes
}

output "network_security_group_name" {
  description = "Monitoring NSG name."
  value       = azurerm_network_security_group.this.name
}

output "network_security_group_id" {
  description = "Monitoring NSG resource ID."
  value       = azurerm_network_security_group.this.id
}
