provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"
}

provider "azuread" {
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"
  subscription_id = "${var.subscription_id}"
}

provider "random" {
}

provider "kubernetes" {
  version                = "~> 1.1"
  host                   = "${azurerm_kubernetes_cluster.keda.kube_config.0.host}"
  client_certificate     = "${base64decode(azurerm_kubernetes_cluster.keda.kube_config.0.client_certificate)}"
  client_key             = "${base64decode(azurerm_kubernetes_cluster.keda.kube_config.0.client_key)}"
  cluster_ca_certificate = "${base64decode(azurerm_kubernetes_cluster.keda.kube_config.0.cluster_ca_certificate)}"
}

provider "tls" {
}

provider "helm" {
  service_account = "clustertiller"

    kubernetes {
      host                   = "${azurerm_kubernetes_cluster.keda.kube_config.0.host}"
      client_certificate     = "${base64decode(azurerm_kubernetes_cluster.keda.kube_config.0.client_certificate)}"
      client_key             = "${base64decode(azurerm_kubernetes_cluster.keda.kube_config.0.client_key)}"
      cluster_ca_certificate = "${base64decode(azurerm_kubernetes_cluster.keda.kube_config.0.cluster_ca_certificate)}"
    }
}
