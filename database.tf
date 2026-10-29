resource "aws_db_subnet_group" "db_subnet" {
  name       = "${var.project_name}-db-subnet"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.project_name}-db-subnet"
  }
}

resource "aws_db_instance" "app_db" {
  identifier             = "${var.project_name}-db"
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  db_name                = "citas_odontologicas"
  username               = "admin_citas"
  password               = var.db_pass
  db_subnet_group_name   = aws_db_subnet_group.db_subnet.name
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  skip_final_snapshot    = true
}