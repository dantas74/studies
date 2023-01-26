resource "aws_elb" "main_lb" {
  name            = "main-elb"
  subnets         = [aws_subnet.pub_1, aws_subnet.pub_2]
  security_groups = [aws_security_group.main_elb.id]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    interval            = 30
    target              = "HTTP:80/"
    timeout             = 3
    unhealthy_threshold = 2
  }

  cross_zone_load_balancing   = true
  connection_draining         = true
  connection_draining_timeout = 400
}
