resource "aws_lb" "cadence_demo_lb" {
  name               = "cadence-demo-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = local.subnets

  enable_deletion_protection = true
}

resource "aws_lb_listener" "cadence_demo_ui_listener" {
  load_balancer_arn = aws_lb.cadence_demo_lb.arn
  port              = 8088
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cadence_demo_target_group.arn
  }
}

resource "aws_lb_target_group" "cadence_demo_target_group" {
  name        = "cadence-demo-target-group"
  port        = 8088
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = local.vpc_id
}