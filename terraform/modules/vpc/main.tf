resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr 
  enable_dns_hostnames = true 
  enable_dns_support = true 

  tags = {
    Name = "vpc-${var.project_name}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id 

  tags = {
   Name = "igw-${var.project_name}" 
  }
}

resource "aws_eip" "nat" {
  vpc = true 
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id 
  subnet_id = aws_subnet.public[0].id 

  tags = {
   Name = "nat-${var.project_name}" 
  }
}

resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)
  vpc_id = aws_vpc.this.id 
  cidr_block = var.public_subnet_cidrs[count.index]
  map_public_ip_on_launch = true 
  availability_zone = element(var.azs, count.index)

  tags = {
   Name = "public-subnet-${count.index + 1}" 
  }
}

resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "private-subnet-${count.index + 1}"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "private-rt"
  }
}

resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}