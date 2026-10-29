# Grupo de seguridad del balanceador de carga
resource "aws_security_group" "alb" {
  name        = "${var.project_name}-alb-sg"
  description = "Permite HTTPS desde Internet al ALB"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTPS desde Internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Salida hacia el backend"
    from_port   = var.backend_port
    to_port     = var.backend_port
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  tags = {
    Name = "${var.project_name}-alb-sg"
  }
}

# Grupo de seguridad del backend EC2
resource "aws_security_group" "backend" {
  name        = "${var.project_name}-backend-sg"
  description = "Permite trafico al backend solo desde el ALB"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "Trafico desde el ALB"
    from_port       = var.backend_port
    to_port         = var.backend_port
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    description = "Salida HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-backend-sg"
  }
}

# Grupo de seguridad de PostgreSQL
resource "aws_security_group" "database" {
  name        = "${var.project_name}-database-sg"
  description = "Permite PostgreSQL solo desde el backend"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-database-sg"
  }
}

# Permite al backend conectarse a PostgreSQL
resource "aws_vpc_security_group_egress_rule" "backend_to_database" {
  security_group_id            = aws_security_group.backend.id
  referenced_security_group_id = aws_security_group.database.id

  description = "Conexion desde el backend hacia PostgreSQL"
  ip_protocol = "tcp"
  from_port   = var.postgres_port
  to_port     = var.postgres_port
}

# Permite a PostgreSQL recibir conexiones del backend
resource "aws_vpc_security_group_ingress_rule" "database_from_backend" {
  security_group_id            = aws_security_group.database.id
  referenced_security_group_id = aws_security_group.backend.id

  description = "PostgreSQL desde el backend"
  ip_protocol = "tcp"
  from_port   = var.postgres_port
  to_port     = var.postgres_port
}