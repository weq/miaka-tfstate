##################################################################################################
### Terraform Init
##################################################################################################


terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 3.52"
    }
  }
  backend "azurerm" {
    resource_group_name = "terraform-state"
    storage_account_name = "miakatfstate"
    container_name = "state"
    key = "prod.terraform.tfstate"
  }
}

##################################################################################################
### Terraform Providers
##################################################################################################

provider "azurerm" {
  subscription_id = var.subscription_id
  features {}
}

##################################################################################################
### Data
##################################################################################################

##################################################################################################
### Resources
##################################################################################################

resource "azurerm_resource_group" "state" {
  name = "terraform-state"
  location = var.location
  tags = var.tags
}

resource "azurerm_storage_account" "state" {
  name = "miakatfstate"
  resource_group_name = azurerm_resource_group.state.name
  location = azurerm_resource_group.state.location
  tags = var.tags
  account_tier = "Standard"
  account_replication_type = "LRS"
  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_storage_container" "state" {
  name = "state"
  storage_account_name = azurerm_storage_account.state.name
}