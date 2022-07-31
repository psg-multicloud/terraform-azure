output "subnet_id" {
    value = azurerm_subnet.subnet_common.id 
}

output "vnet_id" {
    value = azurerm_virtual_network.vnet_common.id
}

output "security_group_id" {
    value = azurerm_network_security_group.nsg_common.id
}