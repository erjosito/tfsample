resource "azurerm_network_interface" "this" {
  count               = var.vm_count
  name                = "${var.vm_name}-${count.index}-nic"
  location            = var.location
  resource_group_name = var.rg
  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.vnet_subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.create_public_ip ? azurerm_public_ip.this[count.index].id : null
  }
  tags = merge(var.tags, {
    environment = var.environment
  })
}

# Public IP Addresses if enabled
resource "azurerm_public_ip" "this" {
  count               = var.create_public_ip ? var.vm_count : 0
  name                = "${var.vm_name}-${count.index}-ip"
  location            = var.location
  resource_group_name = var.rg
  allocation_method   = "Dynamic"
  domain_name_label   = var.domain_name_label != null ? "${var.domain_name_label}-${count.index}" : null
  tags = merge(var.tags, {
    environment = var.environment
  })
}

# Availability Set if enabled
resource "azurerm_availability_set" "this" {
  count                        = var.availability_set_enabled ? 1 : 0
  name                         = "${var.vm_name}-avset"
  location                     = var.location
  resource_group_name          = var.rg
  platform_fault_domain_count  = var.fault_domain_count
  platform_update_domain_count = var.update_domain_count
  managed                      = true
  tags = merge(var.tags, {
    environment = var.environment
  })
}

# Linux Virtual Machines
resource "azurerm_linux_virtual_machine" "this" {
  count                 = var.vm_count
  name                  = "${var.vm_name}-${count.index}"
  resource_group_name   = var.rg
  location              = var.location
  size                  = var.vm_size
  admin_username        = var.admin_username
  network_interface_ids = [azurerm_network_interface.this[count.index].id]
  availability_set_id   = var.availability_set_enabled ? azurerm_availability_set.this[0].id : null
  
  admin_password                  = var.admin_password
  disable_password_authentication = var.admin_password == null ? true : false
  
  dynamic "admin_ssh_key" {
    for_each = var.ssh_public_key != null ? [1] : []
    content {
      username   = var.admin_username
      public_key = var.ssh_public_key
    }
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.os_disk_type
    disk_size_gb         = var.os_disk_size_gb
    name                 = "${var.vm_name}-${count.index}-osdisk"
  }

  source_image_reference {
    publisher = var.os_image.publisher
    offer     = var.os_image.offer
    sku       = var.os_image.sku
    version   = var.os_image.version
  }

  tags = merge(var.tags, {
    environment = var.environment
  })
  
  boot_diagnostics {
    storage_account_uri = var.boot_diagnostics_storage_account
  }
}