project_name        = "azure-todo"
environment         = "dev"
location            = "Central India"
resource_group_name = "rg-azure-todo-dev"

common_tags = {
  Owner       = "DataEngineering"
  Application = "TodoApp"
  CostCenter  = "Engineering"
}

vnet_name = "vnet-azure-todo-dev"

vnet_address_space = [
  "10.10.0.0/16"
]

app_gateway_subnet_name = "snet-appgateway-dev"

app_gateway_subnet_address_prefixes = [
  "10.10.1.0/24"
]

app_service_subnet_name = "snet-appservice-dev"

app_service_subnet_address_prefixes = [
  "10.10.2.0/24"
]

app_service_plan_name = "asp-azure-todo-dev"

app_service_name = "app-azure-todo-dev"

app_service_sku = "B1"

nsg_name = "nsg-azure-todo-dev"

key_vault_name = "kv-azure-todo-dev"

app_gateway_name = "agw-azure-todo-dev"

sql_vm_subnet_name = "snet-sqlvm-dev"

sql_vm_subnet_address_prefixes = [
  "10.10.3.0/24"
]

sql_vm_name = "vm-sql-azure-todo-dev"

sql_vm_size = "Standard_B2s"

sql_vm_admin_username = "sqladmin"


private_endpoint_subnet_name = "snet-privateendpoint-dev"

private_endpoint_subnet_address_prefixes = [
  "10.10.4.0/24"
]

sql_vm_password_expiration_date = "2027-08-24T00:00:00Z"

