module "application_alb" {
  source             = "./application-loadbalancer"
  name               = var.name
  security_groups    = var.security_groups
  subnets            = var.subnets
  tags               = var.tags
}

module "application_alb_taget_group" {
  source  = "./taget-group"
  vpc_id  = var.vpc_id
  tags    = var.tags
}

module "application_alb_listener" {
  source  = "./listener"
  load_balancer_arn = module.application_alb.load_balancer_arn
  certificate_arn   = var.certificate_arn
  target_group_arn  = module.application_alb_taget_group.target_group_arn
  tags              = var.tags
}