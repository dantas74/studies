resource "aws_launch_configuration" "main" {
  name_prefix   = "terraform-launch-config"
  image_id      = data.aws_ami.latest_ubuntu.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.main.key_name
}

resource "aws_autoscaling_group" "main" {
  name                      = "terraform-autoscaling"
  vpc_zone_identifier       = [aws_subnet.pub_1.id, aws_subnet.pub_2.id]
  launch_configuration      = aws_launch_configuration.main.name
  max_size                  = 1
  min_size                  = 2
  health_check_grace_period = 200
  health_check_type         = "EC2"
  force_delete              = true

  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "Launched by Terraform Auto scaling"
  }
}

resource "aws_autoscaling_policy" "main_cpu" {
  autoscaling_group_name = aws_autoscaling_group.main.name
  name                   = "terraform-cpu-policy"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 1
  cooldown               = 200
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {
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
    "AutoScalingGroupName" = aws_autoscaling_group.main.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.main_cpu.arn]
}

resource "aws_autoscaling_policy" "main_cpu_down" {
  autoscaling_group_name = aws_autoscaling_group.main.name
  name                   = "terraform-cpu-policy-down"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = -1
  cooldown               = 200
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {
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
    "AutoScalingGroupName" = aws_autoscaling_group.main.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.main_cpu.arn]
}
