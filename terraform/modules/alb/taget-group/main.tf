resource "aws_lb_target_group" "target_group" {
  name     = "application-target-group-ecs"
  port     = 3000
  protocol = "HTTP"
  target_type = "ip"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/api/health"
    protocol            = "HTTP"
    interval            = 15
    timeout             = 5
    healthy_threshold   = 4
    unhealthy_threshold = 2
  }
  tags = var.tags
}