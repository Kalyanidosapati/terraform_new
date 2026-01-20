provider "aws" {
  region = "us-east-1"
}

variable "ami_value" {
  description = "value"
}

variable "instance_type" {
  description = "value"
  type = map(string)
  default = {
    "dev" = "t2.micro"
    "stage" ="t2.medium"
    "prod" ="t2.xlarge"
  }
}

module "ec2_instance" {
  source = "./modules/ec2_instance"
  ami_value  = var.ami_value
  instance_type = lookup(var.instance_type, terraform.workspace, "t2.micro")
}