module "test" {
    source = "../Day-7-module-source"
    ami-id = "ami-0de716d6197524dd9"
    instance-type = "t2.micro"
    tags = "dev"
  
}