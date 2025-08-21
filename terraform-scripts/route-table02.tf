# route-table-private.tf
# Private Route Table with default route to NAT Gateway
# Associates with private subnets

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.terraform_vpc.id

  tags = {
    Name = "terraform-created-rt02"
  }
}

# Route for internet via NAT Gateway
resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw.id
}

# Associate private subnets
resource "aws_route_table_association" "private_assoc01" {
  subnet_id      = aws_subnet.private_sub01.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_assoc02" {
  subnet_id      = aws_subnet.private_sub02.id
  route_table_id = aws_route_table.private_rt.id
}
