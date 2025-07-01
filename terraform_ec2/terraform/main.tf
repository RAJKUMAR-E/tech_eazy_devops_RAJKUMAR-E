provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "ec2_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  user_data = file("${path.module}/user_data.sh")

  tags = {
    Name        = "ec2-${var.environment}"
    Environment = var.environment
  }
}

