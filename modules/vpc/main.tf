provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc-cidr

  tags = {
    Name = "web-vpc"
  }
}

resource "aws_subnet" "public-1" {
  for_each          = var.public
  vpc_id            = aws_vpc.my_vpc.id
  availability_zone = each.value.az
  cidr_block        = each.value.cidr

  tags = {
    Name = "public-sub-${each.value.az}"
  }
}

resource "aws_subnet" "privates" {
  for_each          = var.private
  vpc_id            = aws_vpc.my_vpc.id
  availability_zone = each.value.azs
  cidr_block        = each.value.cidrs

  tags = {
    Name = "private-sub-${each.value.azs}"
  }
}

resource "aws_internet_gateway" "web-igw" {
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.web-igw.id
  }

  tags = {
    Name = "web-rt"

  }
}

resource "aws_route_table_association" "public-rt-asso1" {
  route_table_id = aws_route_table.public-rt.id
  subnet_id      = aws_subnet.public-1["subnet-1"].id
}

resource "aws_route_table_association" "public-rt-asso2" {
  route_table_id = aws_route_table.public-rt.id
  subnet_id      = aws_subnet.public-1["subnet-2"].id
}

resource "aws_route_table" "private-rt-1a" {
  vpc_id = aws_vpc.my_vpc.id
  
  tags = {
    Name = "web-rt-private-1a"

  }
}

resource "aws_route_table" "private-rt-1b" {
  vpc_id = aws_vpc.my_vpc.id
  
  tags = {
    Name = "web-rt-private-1b"

  }
}

resource "aws_route_table_association" "private-rt-assoc-1a" {
  subnet_id = aws_subnet.privates["private-1"].id
  route_table_id = aws_route_table.private-rt-1a.id
}

resource "aws_route_table_association" "private-rt-assoc-1b" {
  subnet_id = aws_subnet.privates["private-2"].id
  route_table_id = aws_route_table.private-rt-1b.id
}

resource "aws_security_group" "app-sg" {
  description = "for-app"
  name = "app-sg"
  vpc_id = aws_vpc.my_vpc.id
  ingress {
    protocol = "tcp"
    from_port = 443
    to_port = 443
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  ingress {
    protocol = "tcp"
    from_port = 80
    to_port = 80
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress {
    to_port = 0
    from_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}