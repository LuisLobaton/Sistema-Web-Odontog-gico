resource "aws_secretsmanager_secret" "db_secret" {
  name        = "odontologia/db_credentials"
  description = "Credenciales para la base de datos MySQL de citas"
}

resource "aws_secretsmanager_secret_version" "db_secret_val" {
  secret_id     = aws_secretsmanager_secret.db_secret.id
  secret_string = jsonencode({
    username = "admin_citas"
    password = var.db_pass
  })
}