provider "aws" {
  region = "us-east-1"
  profile = "traindev"
}

resource "aws_instance" "ec2" {
  ami           = "ami-05153e28cd40f83b7"
  instance_type = "t2.micro"

  tags = {
    Name = "terraform-example"
  }
}
