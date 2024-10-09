resource "aws_lb" "web-aws_lb" {
  name = var.lb-name
  internal = var.internal-lb
  load_balancer_type = "application"
  subnets = [ var.subnets ]
  security_groups = var.sg
}

resource "aws_lb_listener" "web-listener" {
  port = var.port
  protocol = var.protocol
  load_balancer_arn = aws_lb.web-aws_lb.arn
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.name.arn
  } 
}

resource "aws_lb_target_group" "lb-target" {
  name = "app-target"
  port = var.port
  protocol = var.protocol
  vpc_id = var.vpc_id
}