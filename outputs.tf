output "vpc_id" {
  description = "ID de la VPC principal"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "IDs de las subredes publicas"
  value = [
    aws_subnet.public_a.id,
    aws_subnet.public_b.id
  ]
}

output "private_subnet_ids" {
  description = "IDs de las subredes privadas"
  value = [
    aws_subnet.private_a.id,
    aws_subnet.private_b.id
  ]
}

output "backend_launch_template_id" {
  description = "ID de la plantilla de lanzamiento EC2"
  value       = aws_launch_template.backend.id
}

output "backend_autoscaling_group_name" {
  description = "Nombre del grupo de Auto Scaling del backend"
  value       = aws_autoscaling_group.backend.name
}

output "database_instance_id" {
  description = "Identificador de la instancia RDS PostgreSQL"
  value       = aws_db_instance.postgres.id
}

output "database_endpoint" {
  description = "Endpoint de la base de datos PostgreSQL"
  value       = aws_db_instance.postgres.endpoint
}

output "database_name" {
  description = "Nombre de la base de datos"
  value       = aws_db_instance.postgres.db_name
}