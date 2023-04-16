terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

terraform {
  cloud {
    organization = "orgerta"

    workspaces {
      name = "production_orgerta"
    }
  }
}

provider "aws" {
  region     = var.AWS_REGION
  access_key = var.aws_access_key
  secret_key = var.aws_secret
}

module "network" {
  source     = "./modules/network"
  APP_NAME   = var.APP_NAME
  ENV        = var.ENV
  AWS_REGION = var.AWS_REGION
}

module "cluster" {
  source            = "./modules/cluster"
  PUBLIC_SUBNET_IDS = module.network.subnet-ids
  APP_NAME          = var.APP_NAME
}

module "website" {
  source   = "./modules/storage"
  APP_NAME = var.APP_NAME
}

module "rds" {
  source = "./modules/database"

  APP_NAME    = var.APP_NAME
  DB_SUBNETS  = module.network.subnet-ids
  DB_USERNAME = var.DB_USERNAME
  DB_PASSWORD = var.DB_PASSWORD
  DB_NAME     = var.DB_NAME
  DB_AZ       = "${var.AWS_REGION}a"
  VPC_ID      = module.network.main-vpc-id
}




