variable "vpc_cidr_range" {
    description = "cidr block for the vpc"
    type = string
    default = "10.0.0.0/16"
  
}
variable "public_subnet_cidr" {
    description = "cidr block for the public subnet"
    type = string
    default = "10.0.0.0/24"
}
variable "pvt_subnet_cidr" {
    description = "cidr block for the pvt subnet"
    type = string
    default = "10.0.1.0/24"  
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
    default = "custom-vpc"
  
}
variable "public_subnet_name" {
    description = "name of the public subnet"
    type = string
    default = "pub_subnet"
  
}
variable "pvt_subnet_name" {
    description = "name of the pvt subnet"
    type = string
    default = "pvt_subnet"
  
}
variable "internet_gateway_name" {
    description = "name of the internet gateway"
    type = string
    default = "custom_igw"
  
}
variable "public_route_table_name" {
    description = "name of the public route table"
    type = string
    default = "pub_route_table"
  
}
variable "private_route_table_name" {
    description = "name of the private route table"
    type = string
    default = "pvt_route_table"
  
}
variable "nat_gateway_name" {
    description = "name of the nat gateway"
    type = string
    default = "custom_nat"
}
variable "security_group_name" {
    description = "name of the security group"
    type = string
    default = "my-sg"
  
}
variable "swiggy_instance_name" {
    description = "name of the public ec2 instance"
    type = string
    default = "swiggy_app"
}
variable "zomato_instance_name" {
    description = "name of the private ec2 instance"
    type = string
    default = "zomato_app"
  
}
variable "associate_public_ip_swiggy" {
  description = "Whether to associate a public IP with the swiggy (public) EC2 instance pub ip for pub server"
  type        = bool
  default     = true
}
variable "associate_public_ip_zomato" {
  description = "Whether to associate a public IP with the EC2 instance pub ip for pvt server if you want pub ip give instesd of false you give true"
  type        = bool
  default     = false
}
