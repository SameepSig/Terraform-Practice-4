resource "aws_cloudwatch_metric_alarm" "sameep_scale_up_alarm" {
    alarm_name          = "sameep_scale_up_alarm"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods  = 2
    metric_name         = "CPUUtilization"
    namespace           = "AWS/EC2"
    period              = 120
    statistic           = "Average"
    threshold           = 30
    alarm_description   = "This metric monitors ec2 instance CPU utilization"
    alarm_actions       = [var.auto_scaling_policy_up]
    actions_enabled = true
    dimensions = {
        AutoScalingGroupName = var.auto_scaling_group_name
    }
}

resource "aws_cloudwatch_metric_alarm" "sameep_scale_down_alarm" {
    alarm_name          = "sameep_scale_down_alarm"
    comparison_operator = "LessThanOrEqualToThreshold"
    evaluation_periods  = 2
    metric_name         = "CPUUtilization"
    namespace           = "AWS/EC2"
    period              = 120
    statistic           = "Average"
    threshold           = 5
    alarm_description   = "This metric monitors ec2 instance CPU utilization"
    alarm_actions       = [var.auto_scaling_policy_down]
    actions_enabled = true
    dimensions = {
        AutoScalingGroupName = var.auto_scaling_group_name
    }
}