terraform {
  backend "azurerm" {
    #example properties
    resource_group_name  = "avanade-keda-demo-rg"
    storage_account_name = "kedademostorage"
    container_name       = "terraform-state"
    key                  = "7zJGDm2vDOzuqcxzDxA7W8ylXqQeIy/eNe6UpXAS/WTJ1gQVKs8EkOeTJdEWqOGAycypiUvecqvTK2kWCsP68A=="
    access_key           = "6wVceURjilmh99Ym4sOgeV19qm1arOd55JRUSQzwo6xpEbSbp6BjG5AbDX7BoraBGEMBPjsknoc/lOPW5H5AtQ=="
  }
}

