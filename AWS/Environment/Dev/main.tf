terraform {
  backend "s3" {
    bucket         = "excellentcollection"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "excellentDB"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  availability_zone_1 = var.availability_zone_1
  availability_zone_2 = var.availability_zone_2
}
