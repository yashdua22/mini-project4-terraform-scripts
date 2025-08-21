# nat-gateway.tf
# NAT Gateway for Private Subnets, using Elastic IP and Public Subnet

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_sub01.id

  tags = {
    Name = "terraform-created-nat-gateway01"
  }

  depends_on = [aws_internet_gateway.terraform_igw] # Ensure IGW is created first
}
