terraform {
  backend "s3" {
    bucket = "myaws-bucket-terraform-state-file"
    key    = "terraform-state-file/statefile"
    region = "var.region"
  }
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"
  cidr_block = var.vpc_cidr
  vpc_name = var.vpc_name
}
