# outputs.tf
# Print all created resources after terraform apply

output "created_resources" {
  value = {
    vpc = aws_vpc.terraform_vpc.tags.Name
    subnets = [
      aws_subnet.public_sub01.tags.Name,
      aws_subnet.public_sub02.tags.Name,
      aws_subnet.private_sub01.tags.Name,
      aws_subnet.private_sub02.tags.Name
    ]
    internet_gateway = aws_internet_gateway.terraform_igw.tags.Name
    elastic_ip       = aws_eip.nat_eip.tags.Name
    nat_gateway      = aws_nat_gateway.nat_gw.tags.Name
    route_tables = [
      aws_route_table.public_rt.tags.Name,
      aws_route_table.private_rt.tags.Name
    ]
  }
  description = "List of all resources created in this VPC"
}
