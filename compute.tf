resource "aws_launch_template" "app_template" {
  name_prefix   = "template-odontologia-"
  image_id      = var.ami_id
  instance_type = var.instance_type

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [aws_security_group.ec2_sg.id]
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_profile.name
  }

  user_data = base64encode(<<-EOF
              #!/bin/bash
              echo "Servidor de Odontologia Activo" > index.html
              python3 -m http.server 80 &
              EOF
  )

  tags = {
    Name = "LaunchTemplate-Odontologia"
  }
}

resource "aws_autoscaling_group" "app_asg" {
  name                = "asg-odontologia"
  desired_capacity    = 2
  max_size            = 4
  min_size            = 1
  vpc_zone_identifier = aws_subnet.private_app[*].id

  launch_template {
    id      = aws_launch_template.app_template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "EC2-Odontologia-Instance"
    propagate_at_launch = true
  }

  tag {
    key                 = "Project"
    value               = var.project_name
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = var.environment
    propagate_at_launch = true
  }
}
