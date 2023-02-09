variable "billing_default_tags" {
  type = map(string)

  default = {
    "Owner"   = "matheus-dr"
    "Project" = "Account Setup"
  }
}

data "aws_caller_identity" "current" {}

resource "aws_sns_topic" "billing" {
  name = "billing-alarm-notification-dollar"

  tags = var.billing_default_tags
}

resource "aws_cloudwatch_metric_alarm" "billing" {
  alarm_name          = "account-billing-alarm-dollar"
  alarm_description   = "Billing alarm for this AWS account, used to keep track in costs"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "EstimatedCharges"
  namespace           = "AWS/Billing"
  period              = 28800
  statistic           = "Maximum"
  threshold           = 5

  dimensions = {
    Currency      = "USD"
    LinkedAccount = data.aws_caller_identity.current.account_id
  }

  tags = var.billing_default_tags
}
