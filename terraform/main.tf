module "vnet" {
  source              = "./vnet"
  location            = var.location
  rg                  = var.rg
  environment         = var.environment
}

module "vm" {
  source              = "./vm"
  location            = var.location
  rg                  = var.rg
  vnet_subnet_id      = module.vnet.subnet_id
  environment         = var.environment
}
