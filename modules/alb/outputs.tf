output "aws_lb_target_group" {
  value = aws_lb_target_group.sameep_aws_alb_target_group.arn
}

output "alb_dns_name" {
  value = aws_lb.sameep_aws_alb.dns_name
}