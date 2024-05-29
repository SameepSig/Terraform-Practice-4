resource "aws_internet_gateway" "sameep_internet_gateway_1" {
  vpc_id = var.vpc_id

  tags = {
    Name = "sameep_internet_gateway_1_terraform"
    silo = "intern2"
    owner = "sameep.sigdel"
    terraform = "true"
    environment = "dev"
  }
}