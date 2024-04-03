resource "aws_vpc" "saivpc" {
  cidr_block = var.vpc_cidr
}

resource "aws_subnet" "subnet" {
  vpc_id            = aws_vpc.saivpc.id 
  availability_zone = "ap-south-1a"
  cidr_block        = "10.0.1.0/24"
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.saivpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.saivpc.id

  tags = {
    Name = "main"
  }
}
resource "aws_route_table_association" "subnet" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.route_table.id
}