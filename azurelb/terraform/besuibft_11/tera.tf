provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x.
  # If you are using version 1.x, the "features" block is not allowed.
  features {}
}

# Define the common tags for all resources.
variable "tags" {
  description = "A map of the tags to use for the resources that are deployed."
  type        = "map"

  default = {
    name                  = "Renaultbesuibft11"
    tier                  = "Blockchain VMs"
    application           = "Block chain Performnace study"
    applicationversion    = "1.0.0"
    environment           = "Sandbox"
    infrastructureversion = "1.0.0"
  }
}

# Define prefix for consistent resource naming.
variable "resource_prefix" {
  type        = "string"
  default     = "besuibft11"
  description = "Service prefix to use for naming of resources."
}

# Define Azure region for resource placement.
variable "location" {
  type        = "string"
  default     = "eastus"
  description = "Azure region for deployment of resources."
}

# Define username for use on the hosts.
variable "username" {
  type        = "string"
  default     = "renault"
  description = "Username to build and use on the VM hosts."
}

# ----------------------------END OF VARIABLES------------------------------------

# Create a resource group if it doesn’t exist.
resource "azurerm_resource_group" "resource_group" {
  name     = "${var.resource_prefix}-rg"
  location =  "${var.location}"

  tags = "${var.tags}"
}

# Create virtual network with public and private subnets.
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.resource_prefix}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"

  tags = "${var.tags}"
}

# Create public subnet for hosting bastion/public VMs.
resource "azurerm_subnet" "public_subnet" {
  name                      = "${var.resource_prefix}-pblc-sn001"
  resource_group_name       = "${azurerm_resource_group.resource_group.name}"
  virtual_network_name      = "${azurerm_virtual_network.vnet.name}"
  address_prefix            = "10.0.1.0/24"
  #network_security_group_id = "${azurerm_network_security_group.public_nsg.id}"

  # List of Service endpoints to associate with the subnet.
  service_endpoints         = [
    "Microsoft.ServiceBus",
    "Microsoft.ContainerRegistry"
  ]
}

# Create network security group and SSH rule for public subnet.
resource "azurerm_network_security_group" "public_nsg" {
  name                = "${var.resource_prefix}-pblc-nsg"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"

  # Allow SSH traffic in from Internet to public subnet.
  security_rule {
    name                       = "allow-ssh-all"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = "${var.tags}"
}

# Associate network security group with public subnet.
resource "azurerm_subnet_network_security_group_association" "public_subnet_assoc" {
  subnet_id                 = "${azurerm_subnet.public_subnet.id}"
  network_security_group_id = "${azurerm_network_security_group.public_nsg.id}"
}

# Create a public IP address for bastion host VM in public subnet.
resource "azurerm_public_ip" "public_ip" {
  count = 1
  name                = "${var.resource_prefix}${count.index}-ip"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"
  allocation_method   = "Dynamic"

  tags = "${var.tags}"
}

# Create network interface for bastion host VM in public subnet.
resource "azurerm_network_interface" "bastion_nic" {
  count = 1
  name                      = "${var.resource_prefix}${count.index}-bstn-nic"
  location                  = "${var.location}"
  resource_group_name       = "${azurerm_resource_group.resource_group.name}"
  #network_security_group_id = "${azurerm_network_security_group.public_nsg.id}"

  ip_configuration {
    name                          = "${var.resource_prefix}${count.index}-bstn-nic-cfg"
    subnet_id                     = "${azurerm_subnet.public_subnet.id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${element(azurerm_public_ip.public_ip.*.id,count.index)}"
  }

  tags = "${var.tags}"
}

#Associate bastion network interface to network security group
resource "azurerm_network_interface_security_group_association" "bastion_nic_assoc" {
  count = 1
  network_interface_id      = "${element(azurerm_network_interface.bastion_nic.*.id,count.index)}"
  network_security_group_id = "${azurerm_network_security_group.public_nsg.id}"
}

# Create private subnet for hosting worker VMs.
resource "azurerm_subnet" "private_subnet" {
  name                      = "${var.resource_prefix}-prvt-sn001"
  resource_group_name       = "${azurerm_resource_group.resource_group.name}"
  virtual_network_name      = "${azurerm_virtual_network.vnet.name}"
  address_prefix            = "10.0.2.0/24"
  #network_security_group_id = "${azurerm_network_security_group.private_nsg.id}"

  # List of Service endpoints to associate with the subnet.
  service_endpoints         = [
    "Microsoft.Sql",
    "Microsoft.ServiceBus"
  ]
}

# Create network security group and SSH rule for private subnet.
resource "azurerm_network_security_group" "private_nsg" {
  name                = "${var.resource_prefix}-prvt-nsg"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"

  # Allow SSH traffic in from public subnet to private subnet.
  security_rule {
    name                       = "allow-ssh-public-subnet"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    #source_address_prefix     = "10.0.1.0/24"
	source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # Block all outbound traffic from private subnet to Internet.
  #security_rule {
    #name                       = "deny-internet-all"
    #priority                   = 200
    #direction                  = "Outbound"
    #access                     = "Deny"
    #protocol                   = "Tcp"
    #source_port_range          = "*"
    #destination_port_range     = "*"
    #source_address_prefix      = "*"
    #destination_address_prefix = "*"
  #}

  tags = "${var.tags}"
}

# Associate network security group with private subnet.
resource "azurerm_subnet_network_security_group_association" "private_subnet_assoc" {
  subnet_id                 = "${azurerm_subnet.private_subnet.id}"
  network_security_group_id = "${azurerm_network_security_group.private_nsg.id}"
}

# Create network interface for worker host VM in private subnet.
resource "azurerm_network_interface" "worker_nic" {
  count = 41
  name                      = "${var.resource_prefix}${count.index}-wrkr-nic"
  location                  = "${var.location}"
  resource_group_name       = "${azurerm_resource_group.resource_group.name}"
  #network_security_group_id = "${azurerm_network_security_group.private_nsg.id}"

  ip_configuration {
    name                          = "${var.resource_prefix}${count.index}-wrkr-nic-cfg"
    subnet_id                     = "${azurerm_subnet.private_subnet.id}"
    private_ip_address_allocation = "Dynamic"
  }

  tags = "${var.tags}"
}

#Associate bastion network interface to network security group
resource "azurerm_network_interface_security_group_association" "worker_nic_assoc" {
  count = 41
  network_interface_id          = "${element(azurerm_network_interface.worker_nic.*.id,count.index)}"
  network_security_group_id = "${azurerm_network_security_group.private_nsg.id}"
}

# Generate random text for a unique storage account name.
resource "random_id" "random_id" {
  keepers = {

    # Generate a new ID only when a new resource group is defined.
    resource_group = "${azurerm_resource_group.resource_group.name}"
  }

  byte_length = 8
}

# Create storage account for boot diagnostics.
resource "azurerm_storage_account" "storage_account" {
  name                     = "diag${random_id.random_id.hex}"
  resource_group_name      = "${azurerm_resource_group.resource_group.name}"
  location                 = "${var.location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = "${var.tags}"
}

# Create bastion host VM.
resource "azurerm_virtual_machine" "bastion_vm" {
  count = 1
  name                  = "${var.resource_prefix}${count.index}-bstn-vm001"
  location              = "${var.location}"
  resource_group_name   = "${azurerm_resource_group.resource_group.name}"
  network_interface_ids = ["${element(azurerm_network_interface.bastion_nic.*.id,count.index)}"]
  vm_size               = "Standard_B2ms"
  depends_on            = [azurerm_network_interface_security_group_association.bastion_nic_assoc]
  storage_os_disk {
    name              = "${var.resource_prefix}${count.index}-bstn-dsk001"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "${var.resource_prefix}${count.index}-bstn-vm001"
    admin_username = "${var.username}"
	admin_password = "Nissan!123"
  }

  os_profile_linux_config {
    disable_password_authentication = false

  }

  boot_diagnostics {
    enabled     = "true"
    storage_uri = "${azurerm_storage_account.storage_account.primary_blob_endpoint}"
  }

  tags = "${var.tags}"
}

# Create worker host VM.
resource "azurerm_virtual_machine" "worker_vm" {
  count = 41
  name                  = "${var.resource_prefix}${count.index}-wrkr-vm001"
  location              = "${var.location}"
  resource_group_name   = "${azurerm_resource_group.resource_group.name}"
  network_interface_ids = ["${element(azurerm_network_interface.worker_nic.*.id, count.index)}"]
  depends_on            = [azurerm_network_interface_security_group_association.worker_nic_assoc]
  vm_size               = "Standard_B2ms"
  storage_os_disk {
    name              = "${var.resource_prefix}${count.index}-wrkr-dsk001"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "${var.resource_prefix}${count.index}-wrkr-vm001"
    admin_username = "${var.username}"
	admin_password = "Nissan!123"
  }

  os_profile_linux_config {
    disable_password_authentication = false

  }

  boot_diagnostics {
    enabled     = "true"
    storage_uri = "${azurerm_storage_account.storage_account.primary_blob_endpoint}"
  }

  tags = "${var.tags}"
}

# IDs of virtual networks provisioned.
output "vm_ids" {
  description = "IDs of virtual networks provisioned."
  value       = "${concat(azurerm_virtual_machine.bastion_vm.*.id, azurerm_virtual_machine.worker_vm.*.id)}"
}

# IDs of subnets provisioned.
output "network_subnet_ids" {
  description = "IDs of subnets provisioned."
  value       = "${concat(azurerm_subnet.public_subnet.*.id, azurerm_subnet.private_subnet.*.id)}"
}

# Prefixes of virtual networks provisioned.
output "network_subnet_prefixes" {
  description = "Prefixes of virtual networks provisioned."
  value       = "${concat(azurerm_subnet.public_subnet.*.address_prefix, azurerm_subnet.private_subnet.*.address_prefix)}"
}

# IDs of network security groups provisioned.
output "network_security_group_ids" {
  description = "IDs of network security groups provisioned."
  value       = "${concat(azurerm_network_security_group.public_nsg.*.id, azurerm_network_security_group.private_nsg.*.id)}"
}

# IDs of network interfaces provisioned.
output "network_interface_ids" {
  description = "IDs of network interfaces provisioned."
  value       = "${concat(azurerm_network_interface.bastion_nic.*.id, azurerm_network_interface.worker_nic.*.id)}"
}

# IDs of public IP addresses provisioned.
output "public_ip_ids" {
  description = "IDs of public IP addresses provisioned."
  value       = "${azurerm_public_ip.public_ip.*.id}"
}

# IP addresses of public IP addresses provisioned.
output "public_ip_addresses" {
  description = "IP addresses of public IP addresses provisioned."
  value       = "${azurerm_public_ip.public_ip.*.ip_address}"
}

# FQDNs of public IP addresses provisioned.
output "public_ip_dns_names" {
  description = "FQDNs of public IP addresses provisioned."
  value       = "${azurerm_public_ip.public_ip.*.fqdn}"
}

# IP addresses of private IP addresses provisioned.
output "private_ip_addresses" {
  description = "IP addresses of private IP addresses provisioned."
  value       = "${concat(azurerm_network_interface.bastion_nic.*.private_ip_address, azurerm_network_interface.worker_nic.*.private_ip_address)}"
}

