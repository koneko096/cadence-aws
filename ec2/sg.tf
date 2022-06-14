resource "aws_security_group" "worker_sg" {
  name   = "Service SG"
  vpc_id = local.vpc_id
}

resource "aws_security_group_rule" "worker_poll" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.worker_sg.id
}

#### ADD ADDITIONAL RULES AS NEEDED ####