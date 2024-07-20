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
    nohup busybox httpd -f -p 8080 &
    EOF
  user_data_replace_on_change = true 

  tags = {
    Name = "terraform-example"
  } 
}

resource "aws_security_group" "instance-sg" {
  name = "terraform-example-instance"

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
