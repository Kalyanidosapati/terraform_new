provider "aws" {
    region = "ap-south-1"  # Set your desired AWS region
}
resource "aws_instance" "example" {
    ami           = var.ami_value  # Specify an appropriate AMI ID
    instance_type = var.instance_type
}