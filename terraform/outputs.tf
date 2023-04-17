output "terraform_state_resource_group_name" {
    value = azurerm_resource_group.rg.name
}

output "terraform_state_storage_account" {
    value = azurerm_storage_account.state.name
}

output "terraform_state_storage_container_name" {
    value = azurerm_storage_container.state.name
}