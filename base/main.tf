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
  name     = var.customer_name
  location = var.location
}

module "lc_network" {
  source = "../modules/lc_network"
  count  = var.create_network ? 1 : 0

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

module "ovoc" {
  source = "../modules/ovoc"

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  subnet_id           = var.create_network ? module.lc_network[0].mng_subnet_id : var.mng_subnet_id
  storage_account_uri = var.boot_diagnotstics_storage_account_uri
}

module "ump" {
  source = "../modules/ump"

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  subnet_id           = var.create_network ? module.lc_network[0].mng_subnet_id : var.mng_subnet_id
  storage_account_uri = var.boot_diagnotstics_storage_account_uri
}
