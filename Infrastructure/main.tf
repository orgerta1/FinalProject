terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}



provider "aws" {
  region     = var.AWS_REGION
  access_key = var.aws_access_key
  secret_key = var.aws_secret
}


locals {
  ami_id = "ami-02d0b04e8c50472ce"

}



module "network" {
  source                    = "./modules/network"
  APP_NAME                  = var.APP_NAME
  ENV                       = var.ENV
  AWS_REGION                = var.AWS_REGION
  
}

module "cluster" {
  source                    = "./modules/cluster"
  cluster-subnets           = "./modules/cluster/subnet_ids"
  APP_NAME                  = var.APP_NAME
  ENV                       = var.ENV
  AWS_REGION                = var.AWS_REGION
}
