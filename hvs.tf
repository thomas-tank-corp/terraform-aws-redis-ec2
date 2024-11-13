resource "hcp_vault_secrets_app" "hvs_app" {
  app_name    = var.waypoint_application
  description = "HCP Vault Secrets for Waypoint application ${var.waypoint_application}"
}

resource "hcp_vault_secrets_secret" "redis_ip" {
  app_name     = hcp_vault_secrets_app.hvs_app.app_name
  secret_name  = "redis_ip"
  secret_value = aws_instance.web.public_ip
}

resource "hcp_vault_secrets_secret" "redis_port" {
  app_name     = hcp_vault_secrets_app.hvs_app.app_name
  secret_name  = "redis_port"
  secret_value = "6379"
}

resource "hcp_vault_secrets_secret" "redis_password" {
  app_name     = hcp_vault_secrets_app.hvs_app.app_name
  secret_name  = "redis_password"
  secret_value = random_string.redis_password.id
}