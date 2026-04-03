provider "aws" {
 region = "us-east-1"
}

module "networking" {
 source = "../../modules/networking"
}

module "compute" {
 source = "../../modules/compute"
 vpc_id = module.networking.vpc_id
 subnet_id = module.networking.subnet_id
}

module "iam" {
 source = "../../modules/iam"
}

module "logging" {
 source = "../../modules/logging"
}