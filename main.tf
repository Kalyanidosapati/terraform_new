provider "aws" {
    region = "us-east-1"
}
resource "aws_instance" "example" {
    ami           = "ami-02b8269d5e85954ef"  # Specify an appropriate AMI ID
    instance_type = "t2.micro"
    subnet_id = "subnet-03c9dae1566088a38"
tags = {
    Name = "newinstance"
}
}
resource "aws_s3_bucket" "example" {
  bucket = "my-tf-test-bucket"
tags = {
    Name  = "My bucket"
  }
}
