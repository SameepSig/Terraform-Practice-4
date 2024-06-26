module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
}

module "subnet" {
  source               = "./modules/subnet"
  vpc_id               = module.vpc.sameep_terraform_vpc
  subnet_cidr          = var.subnet_cidr
  subnet_cidr_public_2 = var.subnet_cidr_public_2
  availability_zone_1  = var.availability_zone_1
  availability_zone_2  = var.availability_zone_2
}

module "security_group" {
  source         = "./modules/security_group"
  vpc_id         = module.vpc.sameep_terraform_vpc
  all_cidr_block = var.all_cidr_block
}

module "igw" {
  source = "./modules/igw"
  vpc_id = module.vpc.sameep_terraform_vpc
}

module "rt" {
  source         = "./modules/rt"
  vpc_id         = module.vpc.sameep_terraform_vpc
  all_cidr_block = var.all_cidr_block
  igw_id         = module.igw.igw_id
}

module "rt_association" {
  source                = "./modules/rt_association"
  public_subnet_1_id    = module.subnet.public_subnet_1
  public_subnet_2_id    = module.subnet.public_subnet_2
  public_route_table_id = module.rt.public_rt_1
}

module "alb" {
  source          = "./modules/alb"
  sg_id           = module.security_group.security_group_id
  public_subnet_1 = module.subnet.public_subnet_1
  public_subnet_2 = module.subnet.public_subnet_2
  # ec2_id_1 = module.ec2.ec2_id_1
  vpc_id = module.vpc.sameep_terraform_vpc
}

module "launch_template" {
  source              = "./modules/launch_template"
  ami                 = var.ami
  instance_type       = var.instance_type
  key_name            = var.key_name
  availability_zone_1 = var.availability_zone_1
  security_group_id   = module.security_group.security_group_id
  public_subnet_1     = module.subnet.public_subnet_1
}

module "auto_scaling" {
  source                      = "./modules/auto_scaling"
  aws_launch_configuration_id = module.launch_template.aws_launch_configuration_id
  aws_lb_target_group_arn     = module.alb.aws_lb_target_group
  public_subnet_1     = module.subnet.public_subnet_1
  public_subnet_2     = module.subnet.public_subnet_2
}

module "cloud_watch" {
  source               = "./modules/cloud_watch"
  auto_scaling_group_name = module.auto_scaling.sameep_aws_autoscaling_group
  auto_scaling_policy_up = module.auto_scaling.sameep_auto_scaling_policy_up
  auto_scaling_policy_down = module.auto_scaling.sameep_auto_scaling_policy_down
}