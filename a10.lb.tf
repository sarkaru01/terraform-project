#publicip
resource "azurerm_public_ip" "lb_publicip" {
  name                = "${local.resource_name_prefix}-lb-publicip"
  resource_group_name = azurerm_resource_group.my_rg.name
  location            = azurerm_resource_group.my_rg.location
  allocation_method   = "Static"
  sku                 = "Standard" #basic #premium

  tags = local.project_tags
}

#lb attach the public ip with lb
resource "azurerm_lb" "web_lb" {
 name                = "${local.resource_name_prefix}-lb"
  resource_group_name = azurerm_resource_group.my_rg.name
  location            = azurerm_resource_group.my_rg.location

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.lb_publicip.id
  }
}
#create an backend pool
resource "azurerm_lb_backend_address_pool" "lb_backend_pool" {
  loadbalancer_id = azurerm_lb.web_lb.id #backendpooll need to attach with lb
  name            = "BackEndAddressPool"
} 
##probes health check up 
resource "azurerm_lb_probe" "lb_probe" {
  loadbalancer_id = azurerm_lb.web_lb.id
  name = "frontendprobe"
  protocol = "Tcp"
  #protocol = "Http"
  #request_path"="/var/www/html/mypage.php"
  port = 80 #this is application server port number 8080
  interval_in_seconds = 30 #every 30 second it is going to ping your application path or port number
  number_of_probes = 2 #1 min if it dont get response stop sending the request 
}

#we need to create an load balancer rule
resource "azurerm_lb_rule" "lb_rule" {
  loadbalancer_id = azurerm_lb.web_lb.id 
  name = "lbrule"
  protocol = "Tcp"
  frontend_port = 80 #lb 443
  backend_port = 80 #application port tomcat
  frontend_ip_configuration_name = azurerm_lb.web_lb.frontend_ip_configuration[0].name 
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.lb_backend_pool.id]
  probe_id = azurerm_lb_probe.lb_probe.id 
}

#finally we need to attach the vm nic card with backend pool
resource "azurerm_network_interface_backend_address_pool_association" "nic_backend_pool_association" {
 for_each = var.cartypes
 network_interface_id = azurerm_network_interface.web_nic[each.key].id 
  ip_configuration_name = azurerm_network_interface.web_nic[each.key].ip_configuration[0].name 
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb_backend_pool.id 
}