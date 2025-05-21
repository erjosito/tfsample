resource "azurerm_network_interface" "this" {
  count               = var.vm_count
  name                = "${var.vm_name}-${count.index}-nic"
  location            = var.location
  resource_group_name = var.rg
  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.vnet_subnet_id
    private_ip_address_allocation = "Dynamic"
  }
  tags = {
    environment = var.environment
  }
}

resource "azurerm_linux_virtual_machine" "this" {
  count               = var.vm_count
  name                = "${var.vm_name}-${count.index}"
  resource_group_name = var.rg
  location            = var.location
  size                = var.vm_size
  admin_username      = "azureuser"
  network_interface_ids = [azurerm_network_interface.this[count.index].id]
  admin_password = var.admin_password
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    name                 = "sample-osdisk-${count.index}"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  tags = {
    environment = var.environment
  }
}

output "nic_ids" {
  value = azurerm_network_interface.this[*].id
}