resource "aws_instance" "name" {
    ami = "ami-00ca32bbc84273381"
    instance_type = "t2.micro"
    tags = {
      Name = "eks"
    }
  
}
resource "aws_s3_bucket" "name" {
    bucket = "qwertyuiopasdfghjklzxlkjhgfdsa"
  
}