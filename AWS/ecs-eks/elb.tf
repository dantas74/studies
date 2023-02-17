resource "aws_lb" "this_alb" {
  load_balancer_type = "application"

  #  security_groups = []
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this_alb.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}
