resource "aws_lb" "application_load_balancer" {
  name               = var.name
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = var.subnets
  enable_deletion_protection = false

  enable_cross_zone_load_balancing = true

  tags = var.tags
}