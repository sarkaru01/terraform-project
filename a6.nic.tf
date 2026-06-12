/*resource "azurerm_network_interface" "web_nic" {
  name                = "${local.resource_name_prefix}-web-nic"
  location            = azurerm_resource_group.my_rg.location
  resource_group_name = azurerm_resource_group.my_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.web_subnet.id #nic required subnet 
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.web_vm_publicip.id #nic required public ip
  }
}*/

resource "azurerm_network_interface" "web_nic" {
  for_each = var.cartypes
  name                = "${local.resource_name_prefix}-web-nic-${each.key}"
  location            = azurerm_resource_group.my_rg.location
  resource_group_name = azurerm_resource_group.my_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.web_subnet.id #nic required subnet 
    private_ip_address_allocation = "Dynamic"
   # public_ip_address_id          = azurerm_public_ip.web_vm_publicip.id #nic required public ip
  }
}