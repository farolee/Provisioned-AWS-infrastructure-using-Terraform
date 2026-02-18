# Create a VPC
############################
resource "aws_vpc" "Panda_VPC" {
  cidr_block       = "172.245.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "Panda_VPC"
  }
}

# Public Subnet Pub
###########################
resource "aws_subnet" "Panda_Pub_Sub" {
  vpc_id     = aws_vpc.Panda_VPC.id
  cidr_block = "172.245.10.0/24"
  tags = {
    Name = "Panda_Pub_Sun"
  }
}

# Private Subnet Priv
#########################
resource "aws_subnet" "Panda_Pri_Sub" {
  vpc_id     = aws_vpc.Panda_VPC.id
  cidr_block = "172.245.20.0/24"
  tags = {
    Name = "Panda_Pri_Sub"
  }
}

#Internet Gateway
#####################
resource "aws_internet_gateway" "Panda_IGW" {
  vpc_id = aws_vpc.Panda_VPC.id

  tags = {
    Name = "Panda_IGW"
  }
}

# Create Public Route Table
#############################################
resource "aws_route_table" "Panda_Pub_Rt" {
  vpc_id = aws_vpc.Panda_VPC.id

  tags = {
    Name = "Panda_public-route-table"

  }

}
# Route to Internet
############################
resource "aws_route" "public_internet_route" {
  route_table_id         = aws_route_table.Panda_Pub_Rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.Panda_IGW.id
}

# #Route Table Associte with the IGW
# #######################################
# resource "aws_route_table_association" "public_assoc" {
#   subnet_id      = aws_subnet.Panda_Pub_Sub.id
#   route_table_id = aws_route_table.Panda_Pub_Rt.id
# }

output "Panda_IGW" {
value = aws_internet_gateway.Panda_IGW.id 
}

