output "ump_private_ip" {
  value = azurerm_windows_virtual_machine.ump_vm.private_ip_address
}

output "ump_public_ip" {
  value = azurerm_windows_virtual_machine.ump_vm.public_ip_address
}
