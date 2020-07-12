variable "vpc_cidr" {}
variable "environment" {}
variable "instance_type" {}
variable "region" {}
variable "public_subnet_cidrs" {}
variable "private_key_path" {}
variable "public_key_path" {}
variable "key_name" {}

module "vpc" {
  cidr        = var.vpc_cidr
  environment = var.environment
  source = "./modules/vpc"
}

module "subnet" {
  source             = "./modules/subnet"
  vpc_output_id      = module.vpc.id
  cidr_block         = var.public_subnet_cidrs

}

module "ec2" {
  source = "./modules/ec2"
  vpc_output_id = module.vpc.id
  subnet_id    = module.subnet.id
  private_key_path= var.private_key_path
  public_key_path=  var.public_key_path
  key_name = var.key_name

}

module "elb" {
  source = "./modules/elb"
  vpc_output_id = module.vpc.id
  ec2_output_id = module.ec2.id
  subnet_ids = module.subnet.id
}

provider "aws" {
  region = var.region
  shared_credentials_file ="~/.aws/credentials"
}