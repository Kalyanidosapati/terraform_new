provider "aws" {
  region = "ap-south-1"
}
resource "aws_key_pair" "mykeypub" {
  key_name   = var.key_name
  public_key = file("${path.module}/terraform-key.pub")
}
resource "aws_security_group" "example" {
  name        = var.security_group_name
  vpc_id      = var.vpc_name
  tags = {
    name =var.security_group_name
  }
}
resource "aws_vpc_security_group_ingress_rule" "ingress" {
  security_group_id = aws_security_group.example.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"
}
resource "aws_vpc_security_group_ingress_rule" "sshingress" {
  security_group_id = aws_security_group.example.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"
}
resource "aws_vpc_security_group_egress_rule" "egress" {
  security_group_id = aws_security_group.example.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}
resource "aws_instance" "example" {
  ami = var.ami_value
  instance_type = var.instance_type_value
  subnet_id = var.subnet_id_value
  vpc_security_group_ids = [aws_security_group.example.id]
  key_name = aws_key_pair.mykeypub.key_name
  associate_public_ip_address = true

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("${path.module}/terraform-key")
    host        = self.public_ip
  }
  provisioner "file" {
    source = "app.py"
    destination = "/home/ubuntu/app.py"
  }
  provisioner "remote-exec" {
     inline = [
      "echo 'Hello from the remote instance'",
      "sudo apt update -y && sudo apt-get install -y python3-pip",
      "sudo apt install -y python3-flask",
      "cd /home/ubuntu",
      "pip3 install --user flask",
      "sudo python3 app.py"
    ]
  }  
}
