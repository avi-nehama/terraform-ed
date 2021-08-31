output "ovoc_private_ip" {
  value = azurerm_network_interface.ovoc-nic.private_ip_address
}