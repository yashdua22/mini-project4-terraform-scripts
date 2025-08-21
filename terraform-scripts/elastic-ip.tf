# elastic-ip.tf
# Elastic IP for NAT Gateway

resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "terraform-created-elastic-ip01"
  }
}
