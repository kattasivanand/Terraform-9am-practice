resource "aws_instance" "name" {
    ami = "ami-084a7d336e816906b"
    instance_type = "t2.micro"
    tags = {
      Name = "dev"
    }
  
}
resource "aws_s3_bucket" "name" {
    bucket = "sivanandchittijayaharigundu"
  
}
# this is the command to run a specific resource 
# terraform apply -auto-approve --target=aws_instance.name              ---> resource type and resource name.
# terraform apply -auto-approve --target=aws_s3_bucket.name 