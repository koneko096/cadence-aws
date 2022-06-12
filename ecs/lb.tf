resource "aws_lb" "cadence_demo_lb" {
  name               = "cadence-demo-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = local.subnets
  security_groups    = [ aws_security_group.lb_sg.id ]

  enable_deletion_protection = true
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.cadence_demo_lb.arn
  port              = 443
  protocol          = "HTTPS"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cadence_demo_target_group.arn
  }
}

resource "aws_lb_listener" "lb_listener_redirect" {
  load_balancer_arn = aws_lb.front_end.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = 443
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_target_group" "cadence_demo_ui_target_group" {
  name        = "cadence-demo-target-group"
  port        = 8088
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = local.vpc_id
}