locals {
  inbound_ports  = [80, 22, 443]
  outbound_ports = [0]
}
# Security Groups
resource "aws_security_group" "sg1" {
  vpc_id      = module.VPC.vpc_id
  name        = "sg1"
  description = "Security Group using terraform  "

  dynamic "ingress" {
    for_each = local.inbound_ports
    content {
      description = ""
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
    for_each = local.outbound_ports
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"] #[var.vpc-cidr]
    }
  }
}
