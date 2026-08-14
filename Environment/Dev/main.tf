module "resource_group" {
  source = "../../modules/azurerm_resource_group"
  rgs    = var.rgs
}
module "virtual_network" {
  depends_on = [module.resource_group]
  source     = "../../modules/azurerm_virtual_network"
  vnets      = var.vnets

}
module "subnet" {
  depends_on = [module.virtual_network]
  source     = "../../modules/azurerm_subnet"
  subnets = var.subnets
}
module "public_ip" {
  depends_on = [module.resource_group]
  source     = "../../modules/azurerm_public_ip"
  public_ip  = var.public_ip
}
module "network_interface" {
  depends_on = [module.public_ip, module.subnet]
  source     = "../../modules/azurerm_network_interface"
  nics  = var.nics
}
module "virtual_machine" {
  depends_on = [module.subnet, module.network_interface, module.public_ip]
  source     = "../../modules/azurerm_virtual_machine"
  vms        = var.vms
}
