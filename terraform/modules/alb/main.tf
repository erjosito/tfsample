resource "azurerm_public_ip" "public" {
  name                = var.public_ip_name
  location            = var.location
  resource_group_name = var.rg
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "public" {
  name                = "${var.lb_name}-public"
  location            = var.location
  resource_group_name = var.rg
  sku                 = "Standard"
  frontend_ip_configuration {
    name                 = "PublicLBFrontend"
    public_ip_address_id = azurerm_public_ip.public.id
  }
}

resource "azurerm_lb_backend_address_pool" "public" {
  name            = "PublicBackendPool"
  loadbalancer_id = azurerm_lb.public.id
}

resource "azurerm_lb" "internal" {
  name                = "${var.lb_name}-internal"
  location            = var.location
  resource_group_name = var.rg
  sku                 = "Standard"
  frontend_ip_configuration {
    name                          = "InternalLBFrontend"
    subnet_id                     = var.frontend_subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_lb_backend_address_pool" "internal" {
  name            = "InternalBackendPool"
  loadbalancer_id = azurerm_lb.internal.id
}

resource "azurerm_network_interface_backend_address_pool_association" "public" {
  count                   = length(var.backend_nic_ids)
  network_interface_id    = var.backend_nic_ids[count.index]
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.public.id
}

resource "azurerm_network_interface_backend_address_pool_association" "internal" {
  count                   = length(var.backend_nic_ids)
  network_interface_id    = var.backend_nic_ids[count.index]
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.internal.id
}
