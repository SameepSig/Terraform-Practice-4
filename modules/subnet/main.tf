resource "aws_subnet" "sameep_terraform_subnet_1" {
  vpc_id     = var.vpc_id
  cidr_block = var.subnet_cidr
  availability_zone = var.availability_zone_1

  tags = {
    Name = "sameep_terraform_subnet_1"
    silo = "intern2"
    owner = "sameep.sigdel"
    terraform = "true"
    environment = "dev"
  }
}

resource "aws_subnet" "sameep_terraform_subnet_public_2" {
  vpc_id     = var.vpc_id
  cidr_block = var.subnet_cidr_public_2
  availability_zone = var.availability_zone_2

  tags = {
    Name = "sameep_terraform_subnet_public_2"
    silo = "intern2"
    owner = "sameep.sigdel"
    terraform = "true"
    environment = "dev"
  }
}