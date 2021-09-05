output "ovoc_private_ip" {
  value = azurerm_linux_virtual_machine.ovoc_vm.private_ip_address
}

output "ovoc_public_ip" {
  value = azurerm_linux_virtual_machine.ovoc_vm.public_ip_address
}