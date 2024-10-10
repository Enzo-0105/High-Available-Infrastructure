resource "aws_route53_health_check" "primary" {
  fqdn              = var.domain_name
  type              = "HTTP"
  resource_path     = "/"
  port              = 80
  failure_threshold = 3
  request_interval  = 30
  tags = {
    Name = "Primary Region Health Check"
  }
}

resource "aws_route53_health_check" "secondary" {
  fqdn              = var.domain_name
  type              = "HTTP"
  resource_path     = "/"
  port              = 80
  failure_threshold = 3
  request_interval  = 30
  tags = {
    Name = "Secondary Region Health Check"
  }
}

resource "aws_route53_zone" "example_zone" {
  name = var.domain_name
}

resource "aws_route53_record" "primary_record" {
  zone_id = aws_route53_zone.example_zone.zone_id
  name    = var.domain_name
  type    = "A"
  ttl     = 60
  records = [var.primary_ip]

  set_identifier = "Primary"
  failover_routing_policy {
    type = "PRIMARY"
  }

  health_check_id = aws_route53_health_check.primary.id
}

resource "aws_route53_record" "secondary_record" {
  zone_id = aws_route53_zone.example_zone.zone_id
  name    = var.domain_name
  type    = "A"
  ttl     = 60
  records = [var.secondary_ip]

  set_identifier = "Secondary"
  failover_routing_policy {
    type = "SECONDARY"
  }

  health_check_id = aws_route53_health_check.secondary.id
}
