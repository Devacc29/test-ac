terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
  }
}

provider "azurerm" {
  resource_provider_registrations = "none"
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name  = "tf-str-29"
    storage_account_name = "tfstrbck29"
    container_name       = "terraform-state"
    key                  = "mod.terraform.tfstate"
  }
}