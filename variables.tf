variable "aws_region" {
  description = "Región de AWS donde se desplegará la infraestructura"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Nombre del proyecto para etiquetas"
  type        = string
  default     = "odontologia"
}

variable "environment" {
  description = "Entorno de despliegue"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "Bloque CIDR para la VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "ami_id" {
  description = "ID de la AMI de Amazon Linux para las instancias EC2"
  type        = string
  default     = "ami-0c7217cdde317cfec"
}

variable "instance_type" {
  description = "Tipo de instancia para las máquinas EC2"
  type        = string
  default     = "t2.micro"
}

variable "db_pass" {
  description = "Contraseña para la base de datos RDS y Secrets Manager"
  type        = string
  sensitive   = true
  default     = "ContrasenaSegura2026!"
}

variable "private_subnet_ids" {
  description = "Lista de IDs de subredes privadas para el ASG"
  type        = list(string)
  default     = ["subnet-12345678", "subnet-87654321"]
}