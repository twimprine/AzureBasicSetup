provider "azurerm" {
  features {}

  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
}

# Include a second provider for In-Telecom partner account
provider "azurerm" {
  alias           = "partner"
  features {}

  client_id       = var.partner_client_id
  client_secret   = var.partner_client_secret
  tenant_id       = var.partner_tenant_id
  subscription_id = var.partner_subscription_id
}
