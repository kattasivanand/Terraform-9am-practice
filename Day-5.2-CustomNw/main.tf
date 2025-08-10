# creation of vpc
resource "aws_vpc" "name" {
  cidr_block = var.vpc_cidr_range #cidr blocks without double codes we can write
  tags = {
    Name = "var.vpc_name"
  }
}
#creation of pub-subnet
resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.name.id
    cidr_block = var.public_subnet_cidr #cidr blocks without double codes we can write
    tags = {
      Name = "var.public_subnet_name"
    }

}
#creation of pvt-subnet
resource "aws_subnet" "pvt_subnet" {
    vpc_id = aws_vpc.name.id
    cidr_block = var.pvt_subnet_cidr #cidr blocks without double codes we can write
    tags = {
      Name = "var.pvt_subnet_name"
    }
  
}
#creation igw and attach to vpc
resource "aws_internet_gateway" "custom_igw" {
    vpc_id = aws_vpc.name.id
    tags = {
      Name = "var.internet_gateway_name"
    }
  
}
#creation of pub-rt and edit routes
resource "aws_route_table" "pub_rt" {
    vpc_id = aws_vpc.name.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.custom_igw.id
    }
    tags = {
        Name = "var.public_route_table_name"
    }
  
}
#creation of subnet association for pub-subnet
resource "aws_route_table_association" "pub_association" {
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.pub_rt.id

}
#creation of elastic ip for nat
resource "aws_eip" "nat_eip" {
    domain = "vpc" 
}
#creation of nat gateway for pvt-subnet
resource "aws_nat_gateway" "custom_nat" {
    subnet_id = aws_subnet.public_subnet.id
    allocation_id = aws_eip.nat_eip.id
    tags = {
      Name = "var.nat_gateway_name"
    }
}
#creation pvt-rt and edit routes
resource "aws_route_table" "pvt_rt" {
  vpc_id = aws_vpc.name.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.custom_nat.id
  }
  tags = {
    Name = "var.private_route_table_name"
  }
}

#creation of subnet association for pvt subnet
resource "aws_route_table_association" "pvt_association" {
    subnet_id = aws_subnet.pvt_subnet.id
    route_table_id = aws_route_table.pvt_rt.id
}
#creation of security groups
resource "aws_security_group" "my_sg" {
  name        = "my-sg"
  description = "Allow HTTP, HTTPS, and SSH"
  vpc_id      = aws_vpc.name.id   # Replace with your VPC ID or reference

  # Inbound: HTTP
  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Inbound: SSH
  ingress {
    description = "Allow SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound: All traffic
  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "security_group_name"
  }
}
# creation of pub-servers
resource "aws_instance" "swiggy_app" {
    ami = var.ami_id
    instance_type = var.instance_type #not add double quotes
    subnet_id = aws_subnet.public_subnet.id
    vpc_security_group_ids = [aws_security_group.my_sg.id]
    associate_public_ip_address = var.associate_public_ip_swiggy
    tags = {
      Name = "var.swiggy_instance_name"
    }

}
#creation of pvt-servers
resource "aws_instance" "zomato_app" {
    ami = var.ami_id
    instance_type = var.instance_type # not add double quotes
    subnet_id = aws_subnet.pvt_subnet.id
    vpc_security_group_ids = [aws_security_group.my_sg.id]
    associate_public_ip_address = var.associate_public_ip_zomato
    tags = {
      Name = "var.zomato_instance_name"
    }


}
