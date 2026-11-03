provider "azurerm" {
  features {
    storage {
      data_plane_available = false
    }
  }

  subscription_id     = var.subscription_id
  storage_use_azuread = true
}
