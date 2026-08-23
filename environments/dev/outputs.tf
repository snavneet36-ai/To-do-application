output "resource_group_name" {
  value = module.resource_group.resource_group_name
}

output "resource_group_id" {
  value = module.resource_group.resource_group_id
}

output "resource_group_location" {
  value = module.resource_group.location
}

output "app_service_name" {
  value = module.app_service.app_service_name
}

output "app_service_hostname" {
  value = module.app_service.default_hostname
}

output "managed_identity_principal_id" {
  value = module.app_service.principal_id
}

output "key_vault_name" {
  value = module.key_vault.key_vault_name
}

output "key_vault_uri" {
  value = module.key_vault.key_vault_uri
}

output "sql_vm_id" {
  description = "SQL VM resource ID"
  value       = module.sql_vm.vm_id
}

output "sql_vm_private_ip_address" {
  description = "SQL VM private IP address"
  value       = module.sql_vm.private_ip_address
}

output "sql_vm_network_interface_id" {
  description = "SQL VM network interface ID"
  value       = module.sql_vm.network_interface_id
}