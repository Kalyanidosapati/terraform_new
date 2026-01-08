provider "aws" {
    region = "us-east-1"
}
resource "aws_instance" "example" {
    ami           = "ami-02b8269d5e85954ef"  # Specify an appropriate AMI ID
    instance_type = "t2.micro"
    
}
tags{
    Name = "newinstance"
}
