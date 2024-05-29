resource "aws_route_table" "sameep_route_table_public_1" {
  vpc_id = var.vpc_id

  tags = {
    Name: "Sameep_rt_public_1"
    owner: "sameep.sigdel"
  }

  route {
    cidr_block = var.all_cidr_block
    gateway_id = var.igw_id
  }
}