resource "aws_lb" "cadence_demo_lb" {
  name               = "cadence-demo-lb"
  internal           = false
  load_balancer_type = "network"
  subnets            = local.subnets

  enable_deletion_protection = true
}

resource "aws_lb_listener" "lb_listener_rpc" {
  load_balancer_arn = aws_lb.cadence_demo_lb.arn
  port              = 7933
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cadence_demo_server_target_group.arn
  }
}

resource "aws_lb_listener" "lb_listener_http" {
  load_balancer_arn = aws_lb.cadence_demo_lb.arn
  port              = 80
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cadence_demo_ui_target_group.arn
  }
}

resource "aws_lb_target_group" "cadence_demo_server_target_group" {
  name        = "cadence-demo-server-target-group"
  port        = 7933
  protocol    = "TCP"
  target_type = "ip"
  vpc_id      = local.vpc_id
}

resource "aws_lb_target_group" "cadence_demo_ui_target_group" {
  name        = "cadence-demo-target-group"
  port        = 8088
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = local.vpc_id
}