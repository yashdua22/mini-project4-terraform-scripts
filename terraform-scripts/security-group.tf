# security-group.tf
# Security Group for EC2
# Allows SSH only from your IP and HTTP from anywhere

# Get your public IP dynamically
data "http" "myip" {
  url = "https://checkip.amazonaws.com/"
}

resource "aws_security_group" "terraform_sg" {
  name        = "terraform-created-sg01"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.terraform_vpc.id

  # Ingress: Allow SSH only from your IP
  ingress {
    description = "SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
  }

  # Ingress: Allow HTTP from anywhere
  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Egress: Allow all outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-created-sg01"
  }
}
