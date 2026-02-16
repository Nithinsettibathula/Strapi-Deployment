provider "aws" {
  region = "us-east-1"
}

variable "dockerhub_username" {
  type    = string
}

variable "docker_image_tag" {
  type    = string
  default = "latest"
}

resource "aws_instance" "strapi_server" {
  ami           = "ami-0c101f26f147fa7fd" 
  instance_type = "t2.micro" 
  key_name      = "nithin-Key" # Added your key name here
  vpc_security_group_ids = [aws_security_group.strapi_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install docker -y
              service docker start
              usermod -a -G docker ec2-user
              
              # Wait for Docker to stabilize
              sleep 30
              
              # Pull and run with production flag
              docker pull ${var.dockerhub_username}/strapi-app:${var.docker_image_tag}
              docker run -d --name strapi -p 80:1337 -e NODE_ENV=production ${var.dockerhub_username}/strapi-app:${var.docker_image_tag}
              EOF

  tags = {
    Name = "Strapi-Server-Final"
  }
}

resource "aws_security_group" "strapi_sg" {
  name        = "strapi_sg_final_v3" # Unique name to avoid duplication error
  description = "Allow SSH and Web"

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

output "public_ip" {
  value = aws_instance.strapi_server.public_ip
}