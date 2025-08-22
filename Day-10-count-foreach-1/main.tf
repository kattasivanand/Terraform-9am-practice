resource "aws_instance" "name" {
    ami = "ami-00ca32bbc84273381"
    instance_type = "t2.micro"
    count = 2
    tags = {
     Name = "test-${count.index}"
    } 
  
}