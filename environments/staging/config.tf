terraform {
  cloud {
    organization = "SCI-Dhaka"

    workspaces {
      name = "infrastructure"
    }
  }
  required_providers {
    azurerm = {
      version = "~> 2.98.0"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = "2.16.0"
    }
  }

  # backend "azurerm" {
  #   resource_group_name  = "tstate"
  #   storage_account_name = "stagingucantstate"
  #   container_name       = "terraform-staging"
  #   key                  = "terraform.tfstate"
  # }
  
}

provider "azurerm" {
  subscription_id = local.subscription_id
  tenant_id       = local.tenant_id
  features {}

  client_id       = var.staging_client_id
  client_secret   = var.staging_client_secret
}
