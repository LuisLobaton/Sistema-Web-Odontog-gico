variable "project_name" {
  description = "Nombre del proyecto"
  type        = string
  default     = "proyecto-iac"
}

variable "aws_region" {
  description = "Region de AWS donde se desplegara la infraestructura"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Entorno de trabajo"
  type        = string
  default     = "dev"
}

variable "backend_port" {
  description = "Puerto interno del backend Node.js"
  type        = number
  default     = 3000
}

variable "postgres_port" {
  description = "Puerto de PostgreSQL"
  type        = number
  default     = 5432
}

variable "instance_type" {
  description = "Tipo de instancia EC2 para el backend"
  type        = string
  default     = "t3.small"
}

variable "min_instances" {
  description = "Cantidad minima de instancias EC2"
  type        = number
  default     = 2
}

variable "desired_instances" {
  description = "Cantidad inicial deseada de instancias EC2"
  type        = number
  default     = 2
}

variable "max_instances" {
  description = "Cantidad maxima de instancias EC2"
  type        = number
  default     = 4
}


variable "acm_certificate_arn" {
  description = "ARN del certificado ACM para HTTPS en el ALB"
  type        = string
  default     = ""
}