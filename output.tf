output "resource_group_name" {
  description = "showing the resource group"
  value       = azurerm_resource_group.my_rg.name
}

/*output "public_ip_address" {
  description = "The allocated Azure Public IP address."
  value       = azurerm_public_ip.web_vm_publicip.ip_address
}

output "private_ip_address" {
  description = "Private IP Address"
  value       = azurerm_network_interface.web_nic.private_ip_address

output "public_ip_address" {
  description = "The allocated Azure Public IP address."
  value       = azurerm_public_ip.web_vm_publicip.ip_address
}*/

output "vm_private_ips" {
  description = "Private IP addresses of all Linux VMs"

  value = {
    for vm_name, nic in azurerm_network_interface.web_nic :
    vm_name => nic.private_ip_address
  }
}
