resource "aws_db_subnet_group" "db_subnet" {
  name       = "${var.project_name}-db-subnet"
  subnet_ids = aws_subnet.private_db[*].id

  tags = {
    Name = "${var.project_name}-db-subnet"
  }
}

resource "aws_db_instance" "app_db" {
  identifier        = "${var.project_name}-db"
  allocated_storage = 20
  storage_encrypted = true

  engine         = "mysql"
  engine_version = "8.0"
  instance_class = "db.t3.micro"
  db_name        = "citas_odontologicas"

  username = "admin_citas"
  password = var.db_pass

  db_subnet_group_name   = aws_db_subnet_group.db_subnet.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  iam_database_authentication_enabled = true
  auto_minor_version_upgrade          = true
  copy_tags_to_snapshot               = true

  skip_final_snapshot = true
  deletion_protection = true
}