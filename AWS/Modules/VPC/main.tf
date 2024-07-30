resource "aws_vpc" "proj_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "proj-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.proj_vpc.id
  cidr_block        = var.public_subnet_cidr
  availability_zone = var.availability_zone_1

  tags = {
    Name = "public-subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.proj_vpc.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = var.availability_zone_2

  tags = {
    Name = "private-subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.proj_vpc.id

  tags = {
    Name = "proj-igw"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.proj_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table_association" "public_rt_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name = "proj-nat"
  }
}

resource "aws_eip" "nat_eip" {
  vpc = true
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.proj_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "private-rt"
  }
}

resource "aws_route_table_association" "private_rt_assoc" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}
