output "instance_id" {
  value = aws_instance.my_instance.id
}

output "availability_zone" {
  value = aws_instance.my_instance.availability_zone
}

output "public_ip" {
  value = aws_instance.my_instance.public_ip
}

