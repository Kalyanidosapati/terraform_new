provider "aws" {
  region = "ap-south-1"
}
module "vpc" {
  source = "./modules/vpc"
  vpc_name = "my-vpc"
  cidr_block = "10.0.0.0/16"
  subnet_name = "my-subnet-1"
  subnet_cidr = "10.0.0.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = "true"
  route_cidr = "0.0.0.0/0"
  route_name = "public-rt"
}
module "ec2" {
  source = "./modules/ec2"
  ami_value = "ami-02b8269d5e85954ef"
  instance_type_value = "t2.micro"
  subnet_id_value = module.vpc.subnet_id
  security_group_name = "sg"
  key_name = "my-key-pub"
  vpc_name = module.vpc.vpc_name
}