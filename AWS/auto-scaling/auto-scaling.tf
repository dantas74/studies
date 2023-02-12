resource "aws_launch_template" "this" {
  image_id      = "ami-0cff7528fff583bf9a"
  instance_type = "t2.micro"

  #  vpc_security_group_ids = []
  #  network_interfaces {
  #    subnet_id = ""
  #  }
}

resource "aws_autoscaling_group" "this" {
  max_size         = 5
  desired_capacity = 1
  min_size         = 0

  availability_zones = ["us-east-1a", "us-east-2b", "us-east-3b"]

  load_balancers = [aws_lb.this_alb.id]

  launch_template {
    id = aws_launch_template.this.id
  }
}

resource "aws_lb_target_group" "this" {
  port     = 80
  protocol = "HTTP"
}

resource "aws_autoscaling_policy" "this_cpu" {
  autoscaling_group_name = aws_autoscaling_group.this.arn
  name                   = "terraform-cpu-policy"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 1
  cooldown               = 200
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "cpu_up" {
  alarm_name          = "terraform-cpu-alarm"
  alarm_description   = "Alarm once CPU uses increase"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 30

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.this.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.this_cpu.arn]
}

resource "aws_autoscaling_policy" "this_cpu_down" {
  autoscaling_group_name = aws_autoscaling_group.this.name
  name                   = "terraform-cpu-policy-down"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = -1
  cooldown               = 200
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "cpu_down" {
  alarm_name          = "terraform-cpu-alarm-down"
  alarm_description   = "Alarm once CPU uses decrease"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 10

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.this.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.this_cpu_down.arn]
}
