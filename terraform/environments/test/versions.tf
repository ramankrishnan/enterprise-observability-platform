terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-enterprise-tfstate"
    storage_account_name = "ramanobsstate2026"
    container_name       = "tfstate"
    key                  = "test.tfstate"
    use_cli              = true
    use_azuread_auth     = true
  }
}
