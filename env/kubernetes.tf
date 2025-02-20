locals {
  dockercfg = {
    "${azurerm_container_registry.keda.login_server}" = {
      email    = "notneeded@notneeded.com"
      username = "${azurerm_container_registry.keda.admin_username}"
      password = "${azurerm_container_registry.keda.admin_password}"
    }
  }
}

resource "kubernetes_secret" "demo" {
  metadata {
    name      = "registry"
    namespace = "default"
  }

  # terraform states this is a map of the variables here, it actual wants a structured json object
  # https://github.com/terraform-providers/terraform-provider-kubernetes/issues/81
  data = {
    ".dockercfg" = "${ jsonencode(local.dockercfg) }"
  }

  type = "kubernetes.io/dockercfg"
}

resource "kubernetes_secret" "queue" {
  metadata {
    name      = "queueconnectionstring"
    namespace = "default"
  }

  data = {
    "queueConnectionString" = "${azurerm_storage_account.keda.primary_connection_string}"
  }
}