terraform {
  backend "s3" {
    bucket = "myaws-bucket-terraform-state-file"
    key    = "terraform-state-file/statefile"
    region = var.region
  }
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source    = "./modules/vpc"
  vpc_cidr  = var.vpc_cidr
  vpc_name  = var.vpc_name
}

module "subnets" {
  source       = "./modules/subnets"
  vpc_id       = module.vpc.vpc_id
  subnet_cidrs = var.subnet_cidrs
}

module "internet_gateway" {
  source = "./modules/internet_gateway"
  vpc_id = module.vpc.vpc_id
}

module "route_table" {
  source     = "./modules/route_table"
  vpc_id     = module.vpc.vpc_id
  gateway_id = module.internet_gateway.internet_gateway_id
}

module "route_table_association" {
  source         = "./modules/route_table_association"
  subnet_ids     = module.subnets.subnet_ids
  route_table_id = module.route_table.route_table_id
}

module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
}

module "alb" {
  source            = "./modules/alb"
  vpc_id            = module.vpc.vpc_id
  subnet_ids        = module.subnets.subnet_ids
  alb_name          = var.alb_name
  security_group_id = module.security_group.security_group_id
}
