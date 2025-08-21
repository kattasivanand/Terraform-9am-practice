module "vpc" {
    source = "./modules/vpc"
    cidr_block = "10.0.0.0/16"
    subnet_cidr = "10.0.1.0/24"
    az = "us-east-1a"
  
}
module "ec2" {
    source = "./modules/ec2"
    ami_id = "ami-00ca32bbc84273381"
    instance_type = "t2.micro"
    subnet_id = module.vpc.subnet_id

  
}
module "rds" {
    source = "./modules/rds"
    subnet_id = module.vpc.subnet_id
    instance_class = "db.t3.micro"
    db_name = "mydb"
    db_user = "admin"
    db_password = "admin12345"

  
}
module "s3" {
    source = "./modules/s3"
    awss3 = "testdevprodnareshitsiva"
  
}