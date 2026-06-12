/*resource "azurerm_public_ip" "web_vm_publicip" {
  name                = "${local.resource_name_prefix}-web-vm-publicip"
  resource_group_name = azurerm_resource_group.my_rg.name
  location            = azurerm_resource_group.my_rg.location
  allocation_method   = "Static"
  sku                 = "Standard" #basic #premium

  tags = local.project_tags
}*/

