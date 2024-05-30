output "sameep_aws_autoscaling_group"{
    value = aws_autoscaling_group.sameep_aws_autoscaling_group.name
}

output "sameep_auto_scaling_policy_up" {
  value = aws_autoscaling_policy.scale_up.arn
}

output "sameep_auto_scaling_policy_down" {
  value = aws_autoscaling_policy.scale_down.arn
}