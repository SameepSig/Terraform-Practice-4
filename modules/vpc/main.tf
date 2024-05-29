resource "aws_vpc" "sameep_terraform_vpc" {
  cidr_block = var.vpc_cidr
  tags= {
  Name = "sameep_terraform_vpc"
    silo = "intern2"
    owner = "sameep.sigdel"
    terraform = "true"
    environment = "dev"
  }
}