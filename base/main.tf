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

resource "azurerm_subnet" "subnet" {
  name                 = "internal_subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "ovoc-nic" {
  name                = "ovoc-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "vm" {
  name                             = "ovoc-${var.customer_name}"
  location                         = "${azurerm_resource_group.rg.location}"
  resource_group_name              = "${azurerm_resource_group.rg.name}"
  size                             = var.ovoc_vm_instance_type
  admin_username                   = "ovocadmin"
  admin_password                   = "P@$$w0rd1234!" 
  network_interface_ids            = [azurerm_network_interface.ovoc-nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
 
    # publisher = "MicrosoftWindowsServer"
    # offer     = "WindowsServer"
    # sku       = "2016-Datacenter"
    # version   = "latest"

   publisher = "audiocodes"
   offer     = "audcovoc"
   sku       = "acovoce4azure"
   version   = "latest"

  }
}

output "ovoc_private_ip" {
  value = azurerm_network_interface.ovoc-nic.private_ip_address
}