provider "aws" {
  region = "ap-south-1"
}
resource "aws_vpc" "main" {
  cidr_block  = var.cidr_block
  tags = {
    Name = var.vpc_name
  }
}
resource "aws_subnet" "main" {
  vpc_id     =aws_vpc.main.id
  cidr_block = var.subnet_cidr
  availability_zone = var.availability_zone
  map_public_ip_on_launch = var.map_public_ip_on_launch
  tags = {
    Name = var.subnet_name
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}
resource "aws_route_table" "example" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.route_cidr
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = var.route_name
  }
}
resource "aws_route_table_association" "public_subnet_assoc" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.example.id
}
