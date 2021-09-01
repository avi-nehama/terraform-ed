resource "azurerm_network_interface" "ovoc-nic" {
  name                = "ovoc-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  } 
  # todo: add public IP
}


resource "azurerm_linux_virtual_machine" "ovoc_vm" {
  name                    = "${var.resource_group_name}-ovoc-vm"
  location                = var.location
  resource_group_name     = var.resource_group_name
  size                    = var.ovoc_vm_instance_type
  disable_password_authentication = false
  admin_username          = var.ovoc_admin_username
  admin_password          = var.ovoc_admin_password
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
    offer     = var.ovoc_image_offer
    sku       = var.ovoc_image_sku
    version   = "latest"
  }

  plan {
    name      = "acovoce4azure"
    publisher = "audiocodes"
    product   = "audcovoc"
  }
}

resource "azurerm_managed_disk" "ovoc_data_disk" {
  name                 = "ovoc-data-disk"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = var.ovoc_data_disk_size_gb
}

resource "azurerm_virtual_machine_data_disk_attachment" "ovoc_data_disk_attach" {
  managed_disk_id    = azurerm_managed_disk.ovoc_data_disk.id
  virtual_machine_id = azurerm_linux_virtual_machine.ovoc_vm.id
  lun                = "10"
  caching            = "ReadWrite"
}
