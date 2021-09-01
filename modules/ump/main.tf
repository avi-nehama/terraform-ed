resource "azurerm_network_interface" "ump_nic" {
  name                = "ump_nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_linux_virtual_machine" "ump_vm" {
  name                            = "ump-vm"
  location                        = var.location
  resource_group_name             = var.resource_group_name
  size                            = var.ump_instance_type
  disable_password_authentication = false
  admin_username                  = var.ump_admin_username
  admin_password                  = var.ump_admin_password
  network_interface_ids           = [
    azurerm_network_interface.ump_nic.id
  ]

  # admin_ssh_key {
  #   username   = "adminuser"
  #   public_key = file("~/.ssh/id_rsa.pub")
  # }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_2"
    version   = "latest"
  }
}
