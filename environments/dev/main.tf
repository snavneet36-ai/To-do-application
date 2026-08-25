data "azurerm_client_config" "current" {}

module "resource_group" {
  source = "../../module/resource-group"

  project_name        = var.project_name
  environment         = var.environment
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.common_tags
}

module "networking" {
  source = "../../module/networking"

  vnet_name          = var.vnet_name
  vnet_address_space = var.vnet_address_space

  app_gateway_subnet_name = var.app_gateway_subnet_name

  app_gateway_subnet_address_prefixes = (
    var.app_gateway_subnet_address_prefixes
  )

  app_service_subnet_name = var.app_service_subnet_name

  app_service_subnet_address_prefixes = (
    var.app_service_subnet_address_prefixes
  )

  sql_vm_subnet_name = var.sql_vm_subnet_name

  sql_vm_subnet_address_prefixes = (
    var.sql_vm_subnet_address_prefixes
  )

  nsg_name = var.nsg_name

  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  environment         = var.environment
  tags                = var.common_tags
}

module "app_service" {
  source = "../../module/app-service"

  app_service_plan_name = var.app_service_plan_name
  app_service_name      = var.app_service_name

  location            = var.location
  resource_group_name = module.resource_group.resource_group_name

  app_service_subnet_id = module.networking.app_service_subnet_id

  environment = var.environment
  sku_name    = var.app_service_sku
  tags        = var.common_tags
}

module "key_vault" {
  source = "../../module/key-vault"

  key_vault_name = var.key_vault_name

  location            = var.location
  resource_group_name = module.resource_group.resource_group_name

  tenant_id = data.azurerm_client_config.current.tenant_id

  app_service_principal_id = module.app_service.principal_id

  environment = var.environment
  tags        = var.common_tags
}

module "app_gateway" {
  source = "../../module/app-gateway"

  app_gateway_name = var.app_gateway_name

  location            = var.location
  resource_group_name = module.resource_group.resource_group_name

  subnet_id = module.networking.app_gateway_subnet_id

  backend_hostname = module.app_service.default_hostname

  environment = var.environment
  tags        = var.common_tags
}

module "sql_vm" {
  source = "../../module/sql-vm"

  vm_name             = var.sql_vm_name
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name

  subnet_id = module.networking.sql_vm_subnet_id

  vm_size = var.sql_vm_size

  admin_username = var.sql_vm_admin_username
  admin_password = random_password.sql_vm_admin.result

  environment = var.environment
  tags        = var.common_tags
}

resource "random_password" "sql_vm_admin" {
  length           = 24
  special          = true
  override_special = "!@#$%&*()-_=+"
}

resource "azurerm_key_vault_secret" "sql_vm_admin_password" {
  name         = "sql-vm-admin-password"
  value        = random_password.sql_vm_admin.result
  key_vault_id = module.key_vault.key_vault_id

  depends_on = [
    module.key_vault
  ]
}