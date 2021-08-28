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

resource "azurerm_virtual_network" "vnet" {
  name                = "lcVirtualNetwork"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "mng_subnet" {
  name                 = "mng_subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_security_group" "nsg" {
  name                = "example-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "allowHTTPSInbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "mng_subnet_nsg_association" {
  subnet_id                 = azurerm_subnet.mng_subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}



module "ovoc" {
  source = "../modules/ovoc"

  env_name  = var.customer_name
  location  = var.location
  subnet_id = azurerm_subnet.mng_subnet.id
}


# ---\/-----
# 2*SBC
# Load-balancer
# Subnet
# ---/\-----  

# NSG - open ports
