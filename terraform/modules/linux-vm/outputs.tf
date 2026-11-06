output "vm_name" {
  description = "Monitoring VM name."
  value       = azurerm_linux_virtual_machine.this.name
}

output "vm_id" {
  description = "Monitoring VM resource ID."
  value       = azurerm_linux_virtual_machine.this.id
}

output "private_ip_address" {
  description = "Monitoring VM private IP address."
  value       = azurerm_network_interface.this.private_ip_address
}

output "public_ip_address" {
  description = "Monitoring VM public IP address."
  value       = azurerm_public_ip.this.ip_address
}

output "public_ip_id" {
  description = "Monitoring VM public IP resource ID."
  value       = azurerm_public_ip.this.id
}
