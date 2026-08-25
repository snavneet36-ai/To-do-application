terraform {
  required_version = ">= 1.8.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "sttfstateazuretododev"
    container_name       = "tfstate"
    key                  = "azure-todo-dev.tfstate"
  }
}

provider "azurerm" {
  features {}
}