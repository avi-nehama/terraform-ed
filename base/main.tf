terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
  }
  required_version = ">= 0.14.9"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name      = var.customer_name
  location  = var.location
}

module "lc_network" {
  source = "../modules/lc_network"

  resource_group_name = var.customer_name
  location            = var.location
}

module "ovoc" {
  source = "../modules/ovoc"

  resource_group_name   = var.customer_name
  location              = var.location
  subnet_id             = module.lc_network.mng_subnet_id
}

module "ump" {
  source = "../modules/ump"

  resource_group_name   = var.customer_name
  location              = var.location
  subnet_id             = module.lc_network.mng_subnet_id
}
