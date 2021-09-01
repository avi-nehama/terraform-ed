resource "azurerm_virtual_network" "vnet" {
  name                = "${var.resource_group_name}-ltc-vnet"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "mng_subnet" {
  name                 = "mng_subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_security_group" "nsg" {
  name                = "lc-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
      name                       = "allowHTTPInbound"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
  }
  
  security_rule {
      name                       = "allowHTTPSInbound"
      priority                   = 110
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
  }

  security_rule {
      name                       = "SSH"
      priority                   = 120
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
  }

  security_rule {
      name                       = "VQM"
      priority                   = 130
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "5000-5001"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
  }

  security_rule {
      name                       = "RDP"
      priority                   = 140
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "3389"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
  }

  security_rule {
      name                       = "port_8080"
      priority                   = 150
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "8080"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
  }

  
}

resource "azurerm_subnet_network_security_group_association" "mng_subnet_nsg_association" {
  subnet_id                 = azurerm_subnet.mng_subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
