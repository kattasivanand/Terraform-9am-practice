#creation of vpc
resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "custom_vpc"
    }
}
#creation of pvt subnets for db subnet groups.min two subnets requried in this subnet only rds created
resource "aws_subnet" "pvt_sub_1" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "us-east-1a"
    tags = {
      Name = "pvt-sub-1"
    }
  
}
resource "aws_subnet" "pvt_sub_2" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1b"
    tags = {
      Name = "pvt-sub-2"
    }
  
}
# creation of pub subnet for bastion server
resource "aws_subnet" "pub_subnet" {
  vpc_id = aws_vpc.name.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "pub-sub"
  }
}
#security group for rds and ec2
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
  # inbound: RDS
  ingress {
    description = "ALLOW 3306 from anywhere"
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
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
    Name = "my-sg"
  }
}
# creation of database subnet group
resource "aws_db_subnet_group" "subnet_group" {
    name       = "my-db-subnet-group"
    subnet_ids = [aws_subnet.pvt_sub_1.id,aws_subnet.pvt_sub_2.id]
    tags = {
      Name = "db-subnet-group"
    }
  
}
# creation of rds instance
resource "aws_db_instance" "rds" {
    identifier = "database-1"
    engine = "mysql"
    engine_version = "8.0.42"
    instance_class = "db.t3.micro"
    allocated_storage = 30
    db_name = "sivanand"
    username = "admin"
    password = "sivananddevops"
    db_subnet_group_name = aws_db_subnet_group.subnet_group.name #call db subnet group here.because Terraform can't assign a full object to a field that expects just a string name that's what we are give .name This passes the string name "my-db-subnet-group"
    vpc_security_group_ids = [aws_security_group.my_sg.id]
    publicly_accessible        = false
    skip_final_snapshot = true  #When skip_final_snapshot = true, it tells the system not to create a final backup (snapshot) of the database instance before it is delete.
    #When deleting a database (like in AWS RDS), you normally get a final snapshot — a last backup — so you can restore it later if needed.
    #but if you set skip_final_sanpshot = true that means No backup will be created before deletion.2.If you delete the database, all data is gone.3.You cannot recover it later.
    deletion_protection = false #You can delete the resource at any your given false means if you given true you unable to delete the resource.You cannot delete the resource unless you turn this setting off first.
    multi_az = false #means that Multi-AZ (Availability Zone) deployment is disabled.No standby DB is created.✅ multi_az = true AWS automatically creates a standby replica in a different AZ.Good for production workloads.High availability with automatic failover
    backup_retention_period = 7 # AWS will keep your database backups for 7 days.So if something goes wrong, you can go back in time (up to 7 days ago) and restore your database.after 7 days it will be deleted automatically.
    tags = {
      Name = "sivanand-database"
    }

}
# creation for read replica
resource "aws_db_instance" "read_replica" {
  identifier                 = "database-1-read-replica"
  engine = aws_db_instance.rds.engine
  replicate_source_db        = aws_db_instance.rds.identifier # here you give rds identifier
  instance_class             = "db.t3.micro"
  publicly_accessible        = false
  auto_minor_version_upgrade = true ## this means AWS will automatically upgrade your RDS database when a new minor version of the engine becomes available.If AWS releases a newer minor version like 8.0.43, then:✅ It will be upgraded automatically during a maintenance window
  skip_final_snapshot        = true
  deletion_protection        = false
  #availability_zone       = "us-east-1a" # optional, specify if needed.if you give like this this readreplica instance created 1a A.Z.
  vpc_security_group_ids     = [aws_security_group.my_sg.id]

  depends_on                 = [aws_db_instance.rds]

  tags = {
    Name = "sivanand-database-read-replica"
  }
}

# You don’t need to specify the VPC for a read replica because:The read replica automatically uses the same VPC and networking configuration as the source (primary) RDS instance.
# creation of public server for bastion purpose
resource "aws_instance" "swiggy_app" {
    ami = "ami-084a7d336e816906b"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.pub_subnet.id
    vpc_security_group_ids = [aws_security_group.my_sg.id]
    associate_public_ip_address = true
    tags = {
      Name = "swiggy_app"
    }

}
#creation of private server for rds purpose
resource "aws_instance" "zomato_app" {
    ami = "ami-084a7d336e816906b"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.pvt_sub_1.id
    vpc_security_group_ids = [aws_security_group.my_sg.id]
    associate_public_ip_address = false # this means i'm not allowing public ip
    tags = {
      Name = "zomato_app"
    }


}

