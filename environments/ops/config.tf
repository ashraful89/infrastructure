provider "azurerm" {
  subscription_id = local.subscription_id
  tenant_id       = local.tenant_id
  features {}

  client_id       = var.ops_client_id
  client_secret   = var.ops_client_secret
}

terraform {
    cloud {
    organization = "U-Can"

    workspaces {
      name = "Operations"
    }
  }

  required_providers {
    azurerm = {
      version = "~> 2.56.0"
    }
  }

  # backend "azurerm" {
  #   resource_group_name  = "tstate"
  #   storage_account_name = "opsucantstate"
  #   container_name       = "terraform-ops"
  #   key                  = "terraform.tfstate"
  # }
}

