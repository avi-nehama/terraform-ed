resource "azurerm_network_interface" "ovoc-nic" {
  name                = "ovoc-nic"
  location            = var.location
  resource_group_name = var.env_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_linux_virtual_machine" "ovoc_vm" {
  name                    = "ovoc-vm-${var.env_name}"
  location                = var.location
  resource_group_name     = var.env_name
  size                    = var.ovoc_vm_instance_type
  disable_password_authentication = false
  admin_username          = "adminuser"
  admin_password          = "mzsond6#"
  network_interface_ids   = [
    azurerm_network_interface.ovoc-nic.id
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
    publisher = "audiocodes"
    offer     = "audcovoc"
    sku       = "acovoce4azure"
    version   = "latest"
  }

  plan {
    name      = "acovoce4azure"
    publisher = "audiocodes"
    product   = "audcovoc"
  }
}

output "ovoc_private_ip" {
  value = azurerm_network_interface.ovoc-nic.private_ip_address
}