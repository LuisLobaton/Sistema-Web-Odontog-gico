# Grupo de subredes privadas para la base de datos
resource "aws_db_subnet_group" "main" {
  name = "${var.project_name}-db-subnet-group"

  subnet_ids = [
    aws_subnet.private_a.id,
    aws_subnet.private_b.id
  ]

  tags = {
    Name        = "${var.project_name}-db-subnet-group"
    Environment = var.environment
  }
}

# Base de datos PostgreSQL
resource "aws_db_instance" "postgres" {
  identifier = "${var.project_name}-postgres"

  engine         = "postgres"
  engine_version = "16"
  instance_class = "db.t3.small"

  allocated_storage     = 20
  max_allocated_storage = 100
  storage_type          = "gp3"
  storage_encrypted     = true

  db_name  = "citasodontologicas"
  username = "dbadmin"

  manage_master_user_password = true

  multi_az               = true
  publicly_accessible    = false
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.database.id]

  backup_retention_period    = 7
  auto_minor_version_upgrade = true

  skip_final_snapshot       = false
  final_snapshot_identifier = "${var.project_name}-postgres-final"

  deletion_protection = true

  tags = {
    Name        = "${var.project_name}-postgres"
    Environment = var.environment
  }
}