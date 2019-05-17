
# Generate the SSH key that will be used for the Linux account on the worker nodes
resource "tls_private_key" "keda" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_role_assignment" "keda" {
  scope              = "${azurerm_virtual_network.keda.id}"
  role_definition_name = "Network Contributor"
  principal_id       = "${var.client_id}"
}


resource "azurerm_kubernetes_cluster" "keda" {
  name                = "${var.resource_name}${random_id.keda.dec}"
  location            = "${azurerm_resource_group.keda.location}"
  resource_group_name = "${azurerm_resource_group.keda.name}"
  dns_prefix          = "${var.resource_name}${random_id.keda.dec}"

  # set the Linux profile details using the ssh key we just generated. 
  # Not that it should be used to access the VM directly, hence why I don't 
  # store it in Azure Key Vault
  linux_profile {
    admin_username = "clusteradmin"

    ssh_key {
      key_data = "${tls_private_key.aks.public_key_openssh}"
    }
  }

  kubernetes_version = "1.13.5"

  agent_pool_profile {
    name            = "default"
    count           = 3
    vm_size         = "Standard_B2s"
    os_type         = "Linux"
    os_disk_size_gb = 30

    # Attach the AKS cluster to the subnet within the VNet we have created
    vnet_subnet_id = "${azurerm_subnet.keda.id}"
  }

  service_principal {
    client_id     = "${var.client_id}"
    client_secret = "${var.client_secret}"
  }

  network_profile {
    network_plugin = "azure"
    dns_service_ip = "10.2.2.254"
    service_cidr = "10.2.2.0/24"
    docker_bridge_cidr = "172.17.0.1/16"
  }

  # Enabled RBAC
  role_based_access_control {
    enabled = true
  }
}