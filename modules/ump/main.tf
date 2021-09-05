resource "azurerm_network_interface" "ump_nic" {
  name                            = "ump_nic"
  location                        = var.location
  resource_group_name             = var.resource_group_name
  enable_accelerated_networking   = true
  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_windows_virtual_machine" "ump_vm" {
  name                            = "${var.resource_group_name}-ump-vm"
  location                        = var.location
  resource_group_name             = var.resource_group_name
  size                            = var.ump_instance_type
  admin_username                  = var.ump_admin_username
  admin_password                  = var.ump_admin_password
  network_interface_ids           = [
    azurerm_network_interface.ump_nic.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}
