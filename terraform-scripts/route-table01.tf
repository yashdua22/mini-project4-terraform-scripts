# route-table-public.tf
# Public Route Table with default route to IGW
# Associates with public subnets

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.terraform_vpc.id

  tags = {
    Name = "terraform-created-rt01"
  }
}

# Route to the internet via IGW
resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.terraform_igw.id
}

# Associate public subnets with this RT
resource "aws_route_table_association" "public_assoc01" {
  subnet_id      = aws_subnet.public_sub01.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_assoc02" {
  subnet_id      = aws_subnet.public_sub02.id
  route_table_id = aws_route_table.public_rt.id
}
