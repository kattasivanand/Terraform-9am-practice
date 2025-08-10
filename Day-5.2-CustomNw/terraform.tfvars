#vpc configuration
vpc_cidr_range = "10.0.0.0/16"
vpc_name = "custom-vpc"
#public subnet
public_subnet_cidr = "10.0.0.0/24"
public_subnet_name = "public_subnet"
#private subnet
pvt_subnet_cidr = "10.0.1.0/24"
pvt_subnet_name = "pvt_subnet"
# internet gateway
internet_gateway_name = "custom_igw"
#public route table
public_route_table_name = "pub_route_table"
#private route table
private_route_table_name = "pvt_route_table"
#nat gateway
nat_gateway_name = "custom_nat"
#security group name
security_group_name = "my-sg"
#Ec2 instances
swiggy_instance_name = "swiggy_app"
zomato_instance_name = "zomato_app"
#ip association
associate_public_ip_swiggy = true
associate_public_ip_zomato = false

