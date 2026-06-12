/*resource "azurerm_linux_virtual_machine" "linux_vm" {
  name                = "${local.resource_name_prefix}-linux-vm"
  resource_group_name = azurerm_resource_group.my_rg.name
  location            = azurerm_resource_group.my_rg.location
  size                = var.vm_instance_size ["test"]
  admin_username      = "azureuser"
  network_interface_ids = [
    azurerm_network_interface.web_nic.id,
  ]

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("${path.module}/ssh-keys/terraform-azure.pem.pub")
    #public_key = file(C:\Users\gopal\Desktop\terraform-project\ssh-keys\terraform-azure.pem.pub) --- IGNORE ---
    #this path.module will always look for your file in the current directory
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  custom_data = filebase64("${path.module}/app/app.sh") #it will read the content of the file and convert it to base64 encoded string and pass it to the custom data
}*/
#==============================================

# VM creat with Load Balancer
resource "azurerm_linux_virtual_machine" "linux_vm" {
  for_each = var.cartypes
  name                = "${local.resource_name_prefix}-linux-vm-${each.key}"
  resource_group_name = azurerm_resource_group.my_rg.name
  location            = azurerm_resource_group.my_rg.location
  size                = var.vm_instance_size["dev"] #it will look for the value of the key in the map and return the value
  admin_username      = "azureuser"
  network_interface_ids = [
    azurerm_network_interface.web_nic[each.key].id,
  ]

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("${path.module}/ssh-keys/terraform-azure.pem.pub")
    #public_key = file(C:\Users\gopal\Desktop\terraform-project\ssh-keys\terraform-azure.pem.pub) --- IGNORE ---
    #this path.module will always look for your file in the current directory
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  custom_data = filebase64("${path.module}/app/app.sh") #it will read the content of the file and convert it to base64 encoded string and pass it to the custom data
}