output "vm_id" {
  description = "SQL VM resource ID"
  value       = azurerm_windows_virtual_machine.sql_vm.id
}

output "private_ip_address" {
  description = "SQL VM private IP address"
  value       = azurerm_network_interface.sql_vm.private_ip_address
}

output "network_interface_id" {
  description = "SQL VM network interface ID"
  value       = azurerm_network_interface.sql_vm.id
}