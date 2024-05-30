resource "aws_autoscaling_group" "sameep_aws_autoscaling_group" {
  name = "sameep_aws_autoscaling_group"
  # availability_zones = [var.availability_zone_1] # Used when you're creating an Auto Scaling group in EC2-Classic or a default VPC.
  min_size           = 1
  desired_capacity   = 1
  max_size           = 2
  vpc_zone_identifier = [var.public_subnet_1, var.public_subnet_2] # Used when you're creating an Auto Scaling group in a VPC that you've defined.

  # We can also directly associate a target group with an autoscaling group using   target_group_arns = [aws_lb_target_group.example.arn] instead of using aws_autoscaling_attachment resource.

  health_check_grace_period = 300
  health_check_type         = "ELB"

  launch_template {
    id      = var.aws_launch_configuration_id
    version = "$Latest"
  }
}

resource "aws_autoscaling_attachment" "sameep_aws_autoscaling_attachment" {
  autoscaling_group_name = aws_autoscaling_group.sameep_aws_autoscaling_group.id
  lb_target_group_arn    = var.aws_lb_target_group_arn
}

resource "aws_autoscaling_policy" "scale_up" {
  name                   = "scale_up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.sameep_aws_autoscaling_group.id
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "scale_down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.sameep_aws_autoscaling_group.id
}