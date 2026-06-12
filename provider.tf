terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
     # version = "=4.1.0" #in production always give the version number
    }
  }
  backend "azurerm" {
    resource_group_name   = "us-tf-storage-rg" 	#replace the same with your storage account rg
    storage_account_name  = "usstorage5674" 	#replace the same with your own storage account
    container_name        = "us-tfstate-cont01" 		#name of the container
    key                   = "us.tfstate" 		#state file will be stored with this name
  }
}

/*# Configure the Microsoft Azure Provider
provider "azurerm" {
  # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.

  features {}
}*/

variable "client_id" {
  type = string
}
 
variable "client_secret" {
  type = string
}
 
variable "subscription_id" {
  type = string
}
 
variable "tenant_id" {
  type = string
}

