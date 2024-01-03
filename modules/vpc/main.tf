#create a vpc

resource "aws_vpc" "vpc1" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  tags = {
    Name = "${var.project_title}-vpc"
  }
}

#internet gateway
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "${var.project_title}-internet_gateway"
  }
}

#get available data source
data "aws_availability_zones" "available_zones" {}

#public subnet 1
resource "aws_subnet" "public_subnet_az1" {
  vpc_id = aws_vpc.vpc1.id
  cidr_block = var.publicSubnetcidr1
  availability_zone = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name ="${var.project_title}-subnet1"
  }
}

#public subnet 2
resource "aws_subnet" "public_subnet_az2" {
  vpc_id = aws_vpc.vpc1.id
  cidr_block = var.publicSubnetcidr2
  availability_zone = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name ="${var.project_title}-subnet2"
  }
}

#route table
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc1.id

  route = {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "${var.project_title}-route-table"
  }
}

# associate public subnet1 to route table"
resource "aws_route_table_association" "public_subnet1_route_table_association" {
  subnet_id           = aws_subnet.public_subnet_az1.id
  route_table_id      = aws_route_table.route_table.id
}


# associate public subnet2 to route table"
resource "aws_route_table_association" "public_subnet2_route_table_association" {
  subnet_id           = aws_subnet.public_subnet_az2.id
  route_table_id      = aws_route_table.route_table.id
}


