provider "aws" {
  region = "ap-south-1"
}
module "s3" {
  source = "./modules/s3"
  bucket_name = "new-buckt-terra-statefile"
  object_name = "terraform.txt"
  source_path = "./modules/s3/files/terraform.txt"
}
module "vpc" {
  source = "./modules/vpc"
  vpc_name = "my-vpc"
  cidr_block = "10.0.0.0/16"
  subnet_name = "my-subnet-1"
  subnet_cidr = "10.0.1.0/24"
}
module "ec2_instance" {
  source = "./modules/ec2_instance"
  ami_value = "ami-02b8269d5e85954ef"
  instance_type_value = "t2.micro"
  subnet_id_value = module.vpc.subnet_id_value
}
