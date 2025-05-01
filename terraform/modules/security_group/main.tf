resource "aws_security_group" "security_group" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  tags = var.tags
}


resource "aws_security_group_rule" "ingress" {
  count             = length(var.ingress_rules)
  type              = "ingress"
  from_port   = var.ingress_rules[count.index].from_port
  to_port     = var.ingress_rules[count.index].to_port
  protocol    = var.ingress_rules[count.index].protocol
  
  cidr_blocks       = var.ingress_rules[count.index].cidr != null ? var.ingress_rules[count.index].cidr : null
  source_security_group_id = var.ingress_rules[count.index].source_security_group_id != null ? var.ingress_rules[count.index].source_security_group_id : null
  prefix_list_ids = var.ingress_rules[count.index].prefix_list_ids != null ? var.ingress_rules[count.index].prefix_list_ids : null

  security_group_id = aws_security_group.security_group.id
}

resource "aws_security_group_rule" "egress" {
  count             = length(var.egress_rules)
  type              = "egress"
  from_port   = var.egress_rules[count.index].from_port
  to_port     = var.egress_rules[count.index].to_port
  protocol    = var.egress_rules[count.index].protocol
  
  cidr_blocks       = var.egress_rules[count.index].cidr != null ? var.egress_rules[count.index].cidr : null
  source_security_group_id = var.egress_rules[count.index].source_security_group_id != null ? var.egress_rules[count.index].source_security_group_id : null
  prefix_list_ids = var.egress_rules[count.index].prefix_list_ids != null ? var.egress_rules[count.index].prefix_list_ids : null
  security_group_id = aws_security_group.security_group.id
}