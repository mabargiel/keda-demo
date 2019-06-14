terraform {
  backend "azurerm" {
    #example properties
    resource_group_name  = "avanade-terraform-rg"
    storage_account_name = "avanadeterraformstorage"
    container_name       = "terraform"
    key                  = "eZI9R8pGmtIJpmj782zlnwHq/615SKHw7SI6T4tUOB1krCqvKMwAHMA5XvKBgWaVHhQXApfsSLYcOywmLB0QQQ=="
    access_key           = "eZI9R8pGmtIJpmj782zlnwHq/615SKHw7SI6T4tUOB1krCqvKMwAHMA5XvKBgWaVHhQXApfsSLYcOywmLB0QQQ=="
  }
}