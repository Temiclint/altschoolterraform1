terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

#vpc 

module "vpc" {
  source            = "../modules/vpc"
  region            = var.region
  project_title     = var.project_title
  vpc_cidr_block    = var.vpc_cidr_block
  publicSubnetcidr1 = var.publicSubnetcidr1
  publicSubnetcidr2 = var.publicSubnetcidr2
  ami               = var.ami
  type              = var.type
  key_pair          = var.key_pair
}
