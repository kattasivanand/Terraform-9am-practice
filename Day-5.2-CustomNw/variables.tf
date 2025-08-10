variable "vpc_cidr_range" {
    description = "cidr block for the vpc"
    type = string
    default = ""
  
}
variable "public_subnet_cidr" {
    description = "cidr block for the public subnet"
    type = string
    default = ""
}
variable "pvt_subnet_cidr" {
    description = "cidr block for the pvt subnet"
    type = string
    default = ""  
}
variable "ami_id" {
    description = "ami id to use for ec2 instance"
    type = string
    default = "ami-084a7d336e816906b"
}
variable "instance_type" {
    description = "instance type for ec2 instance"
    type = string
    default = "t2.micro"
  
}
variable "vpc_name" {
    description = "name of the vpc"
    type = string
    default = ""
  
}
variable "public_subnet_name" {
    description = "name of the public subnet"
    type = string
    default = ""
  
}
variable "pvt_subnet_name" {
    description = "name of the pvt subnet"
    type = string
    default = ""
  
}
variable "internet_gateway_name" {
    description = "name of the internet gateway"
    type = string
    default = ""
  
}
variable "public_route_table_name" {
    description = "name of the public route table"
    type = string
    default = ""
  
}
variable "private_route_table_name" {
    description = "name of the private route table"
    type = string
    default = ""
  
}
variable "nat_gateway_name" {
    description = "name of the nat gateway"
    type = string
    default = ""
}
variable "security_group_name" {
    description = "name of the security group"
    type = string
    default = ""
  
}
variable "swiggy_instance_name" {
    description = "name of the public ec2 instance"
    type = string
    default = ""
}
variable "zomato_instance_name" {
    description = "name of the private ec2 instance"
    type = string
    default = ""
  
}
variable "associate_public_ip_swiggy" {
  description = "Whether to associate a public IP with the swiggy (public) EC2 instance pub ip for pub server"
  type        = bool
}
variable "associate_public_ip_zomato" {
  description = "Whether to associate a public IP with the EC2 instance pub ip for pvt server if you want pub ip give instesd of false you give true"
  type        = bool
}
