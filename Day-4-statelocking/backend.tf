terraform {
  backend "s3" {
    bucket = "day4statelockingmach"
    key = "day-4/terraform.tfstate"
    region = "us-east-1" 
  }
}