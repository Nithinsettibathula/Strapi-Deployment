provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "strapi_server" {
  # Standard Amazon Linux 2 AMI (Highly Stable)
  ami           = "ami-0c101f26f147fa7fd" 
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.strapi_sg.id]

  tags = { Name = "Debug-Server-Nithin" }
}

resource "aws_security_group" "strapi_sg" {
  name = "strapi_sg_debug"
  ingress { from_port = 22; to_port = 22; protocol = "tcp"; cidr_blocks = ["0.0.0.0/0"] }
  ingress { from_port = 80; to_port = 80; protocol = "tcp"; cidr_blocks = ["0.0.0.0/0"] }
  egress { from_port = 0; to_port = 0; protocol = "-1"; cidr_blocks = ["0.0.0.0/0"] }
}

output "public_ip" { value = aws_instance.strapi_server.public_ip }
