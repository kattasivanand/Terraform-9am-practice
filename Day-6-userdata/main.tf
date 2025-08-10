resource "aws_instance" "name" {
    ami = "ami-084a7d336e816906b"
    instance_type = "t2.micro"
    user_data = file("test.sh")
    tags = {
      Name = "siva"
    }
  
}