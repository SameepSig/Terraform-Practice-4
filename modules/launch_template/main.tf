resource "aws_launch_template" "sameep_aws_lauch_template" {
  name = "sameep_aws_lauch_template"

# We can't specify cpu options block because we are using t2.micro instance type which is already fixed.
#   cpu_options {
#     core_count       = 1
#     threads_per_core = 1
#   }

  credit_specification {
    cpu_credits = "standard"
  }

  image_id = var.ami

  instance_initiated_shutdown_behavior = "terminate"

  instance_type = var.instance_type

  key_name = var.key_name

  metadata_options {
    http_endpoint               = "enabled" #enables the instance metadata service on the EC2 instance.
    http_tokens                 = "required" #all requests to the instance metadata service be made with a valid session token. 
    http_put_response_hop_limit = 1 #By limiting this to 1, you're ensuring that the response doesn't get routed through multiple other systems, which can be a security risk.
    instance_metadata_tags      = "enabled"
  }

  network_interfaces {
    associate_public_ip_address = true
    subnet_id = var.public_subnet_1
    security_groups = [var.security_group_id]
  }

  placement {
    availability_zone = var.availability_zone_1
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
        Name = "sameep_aws_lauch_template_1"
        silo = "intern2"
        owner = "sameep.sigdel"
        terraform = "true"
        environment = "dev"
    }
  }

#   user_data = filebase64("${path.module}/example.sh")
}