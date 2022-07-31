#http://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network#argument-reference
#http://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet
#http://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group
#http://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association

resource "azure_resource_group" "rg_common" {
   name = "rede_common"
   location = var.location

   tags = local.common_tags
}

resource "azurerm_virtual_network" "vnet_common" {
  name                = "vnet_common"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_common.name
  address_space       = ["10.0.0.0/16"]

  tags = local.common_tags
  
}

resource "azurerm_subnet" "subnet_common" {
  name                 = "subnet_common"
  resource_group_name  = azurerm_resource_group.rg_common.name
  virtual_network_name = azurerm_virtual_network.vnet_common.name
  address_prefixes     = ["10.0.1.0/24"]

  }

  resource "azurerm_network_security_group" "nsg_common" {
  name                = "nsg_common"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_common.name

  security_rule {
    name                       = "SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = local.common_tags  
}

resource "azurerm_subnet_network_security_group_association" "snsga_01" {
  subnet_id                 = azurerm_subnet.subnet_common.id
  network_security_group_id = azurerm_network_security_group.nsg_common.id
}
