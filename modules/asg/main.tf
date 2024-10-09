resource "aws_autoscaling_group" "app-scaling" {
  min_size = var.min
  max_size = var.max
  desired_capacity = var.desire
  health_check_grace_period = 300
  health_check_type         = "ELB"
  instance_maintenance_policy {
    min_healthy_percentage = 90
    max_healthy_percentage = 120
  }
  vpc_zone_identifier = var.zones 
  target_group_arns = var.target-arn

  launch_template {
    id = aws_launch_template.web-temp
    version = "$Latest"
  }
}

resource "aws_launch_template" "web-temp" {
  instance_type = var.instance_type
  image_id = var.image_id
  vpc_security_group_ids = var.sg
  user_data = <<-EOF
  #!/bin/bash
  sudo apt install nginx -y
  sudo systemctl start nginx 
  EOF
  tags = {
    Name = "web-app"
  }
}