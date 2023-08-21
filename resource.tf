# creating a VPC
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc

resource "aws_vpc" "prod" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "prod"
  }
}

# creating an internet gateway
resource "aws_internet_gateway" "prod" {
  vpc_id = aws_vpc.prod.id

  tags = {
    Name = "prod"
  }
}

# creating a subnet
resource "aws_subnet" "pub-subnet" {
  vpc_id                  = aws_vpc.prod.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "public-subnet"
  }
}

# private subnet
resource "aws_subnet" "private-subnet" {
  vpc_id     = aws_vpc.prod.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "private-subnet"
  }
}

# creating a route table
resource "aws_route_table" "pub-route-table" {
  vpc_id = aws_vpc.prod.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.prod.id
  }

  tags = {
    Name = "pub-route-table"
  }
}

# private route table
resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.prod.id
  tags = {
    Name = "private-route-table"
  }
}

# route table association
# associate public route table
resource "aws_route_table_association" "pub-route-table-association" {
  subnet_id      = aws_subnet.pub-subnet.id
  route_table_id = aws_route_table.pub-route-table.id
}

# associate private route table
resource "aws_route_table_association" "private-route-table-association" {
  subnet_id      = aws_subnet.private-subnet.id
  route_table_id = aws_route_table.private-route-table.id
}
