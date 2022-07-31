terraform {

  required_version = ">= 1.0.0"

    azurerm = {
     source = "hashicorp/azurerm"
     version = "3.16.0"
    }
  }
   backend "azurerm" {
    resource_group_name = "storage-account-rg"
    storage_account_name = "stoacc_teste1-terraform"
    container_name = "container-terraform"
    key = "azure-vnet/terraform.tfstate"
   }

provider "azurerm" {
   features {}
  }

        
    