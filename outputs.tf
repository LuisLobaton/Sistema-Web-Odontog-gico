output "launch_template_id" {
  description = "ID del Launch Template para el backend"
  value       = aws_launch_template.app_template.id
}

output "autoscaling_group_name" {
  description = "Nombre del Auto Scaling Group"
  value       = aws_autoscaling_group.app_asg.name
}