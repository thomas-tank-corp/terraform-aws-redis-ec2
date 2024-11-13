output "ip" {
  value = aws_instance.web.public_ip
}

output "password" {
  sensitive = true
  value     = random_string.redis_password.id
}