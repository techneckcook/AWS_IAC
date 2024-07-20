provider "aws" {
  region = "us-east-1"
  profile = "traindev"
}

resource "aws_instance" "ec2" {
  ami           = "ami-05153e28cd40f83b7"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance-sg.id]

  user_data = <<-EOF
    #!/bin/bash
    echo "Hello, World" > index.html
    nohup busybox httpd -f -p ${var.server_port} &
    EOF
  user_data_replace_on_change = true 

  tags = {
    Name = "terraform-example"
  } 
}

#Show Public IP of EC2
output "public_ip" {
  value = aws_instance.ec2.public_ip
  description = "The public IP address of the web server"
}

resource "aws_security_group" "instance-sg" {
  name = "terraform-example-instance"

  ingress {
    from_port = var.server_port
    to_port = var.server_port
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
