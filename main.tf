data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "random_string" "redis_password" {
  length  = 16
  special = false
}

resource "aws_instance" "web" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t3.small"
  security_groups = [aws_security_group.allow_redis_traffic.name]

  user_data = templatefile("boot.sh", { redis_password = random_string.redis_password.id })

  tags = {
    Name = "${var.waypoint_add_on}"
  }
}
