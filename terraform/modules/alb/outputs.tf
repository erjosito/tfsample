output "public_lb_id" {
  value = azurerm_lb.public.id
}

output "internal_lb_id" {
  value = azurerm_lb.internal.id
}
