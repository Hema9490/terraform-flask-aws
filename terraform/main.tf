# Latest Amazon Linux 2023 image, looked up automatically
data "aws_ssm_parameter" "al2023" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

# Use the default network that every AWS account already has
data "aws_vpc" "default" {
  default = true
}

# Firewall: allow web traffic (port 80) only. SSH is NOT opened.
resource "aws_security_group" "web" {
  name        = "${var.project_name}-web-sg"
  description = "Allow HTTP"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-web-sg"
  }
}

# The server. The Flask app is installed at boot by user_data.
resource "aws_instance" "web" {
  ami                         = data.aws_ssm_parameter.al2023.value
  instance_type               = var.instance_type
  vpc_security_group_ids      = [aws_security_group.web.id]
  associate_public_ip_address = true

  user_data = templatefile("${path.module}/user_data.sh.tpl", {
    app_b64 = filebase64("${path.module}/../app/app.py")
    req_b64 = filebase64("${path.module}/../app/requirements.txt")
  })
  user_data_replace_on_change = true

  tags = {
    Name = "${var.project_name}-server"
  }
}
