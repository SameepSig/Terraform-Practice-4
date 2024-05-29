resource "aws_autoscaling_group" "sameep_aws_autoscaling_group" {
    availability_zones = [var.availability_zone_1]
    min_size           = 1
    desired_capacity   = 1
    max_size           = 2

    launch_template {
        id      = var.aws_launch_configuration_id
        version = "$Latest"
    }
}

resource "aws_autoscaling_attachment" "sameep_aws_autoscaling_attachment" {
  autoscaling_group_name = aws_autoscaling_group.sameep_aws_autoscaling_group.id
  lb_target_group_arn    = var.aws_lb_target_group_arn
}