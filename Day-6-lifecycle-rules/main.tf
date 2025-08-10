resource "aws_instance" "name" {
    ami = "ami-084a7d336e816906b"
    instance_type = "t2.micro"
    availability_zone = "us-east-1a"

    tags = {
      Name = "dev"
    }
    lifecycle {
        #prevent_destroy = true              # based on requriment you can use true or false
        #create_before_destroy = true         # based on requriment you can use true or false
        #ignore_changes = [ tags, ]            # not only tags you can give ami instance type 

      
    }
  
}