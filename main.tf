terraform {
  backend "s3" {
    bucket = "nithin-settibathula-strapi" 
    key    = "strapi/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

variable "docker_image_tag" { default = "latest" }
variable "dockerhub_username" { type = string }

resource "aws_instance" "strapi_server" {
  ami           = "ami-0c55b159cbfafe1f0" 
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.strapi_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install -y docker.io
              sudo systemctl start docker
              sudo docker run -d -p 80:1337 ${var.dockerhub_username}/strapi-app:${var.docker_image_tag}
              EOF

  tags = { Name = "Strapi-Server-Nithin" }
}

resource "aws_security_group" "strapi_sg" {
  name = "strapi_sg_nithin"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "public_ip" { value = aws_instance.strapi_server.public_ip }
