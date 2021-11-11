terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.84.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "storage-resources"
    storage_account_name = "testsaeastus"
    container_name       = "tfstatefiles"
    key                  = "aks-cluster.tfstate"
  }
}

provider "azurerm" {
  features {}
}
