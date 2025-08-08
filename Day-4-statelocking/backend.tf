terraform {
  backend "s3" {
    bucket = "day4statelockingmach"
    key = "day-4/terraform.tfstate"
    region = "us-east-1"
    #use_lockfile = true #supports latest version >=1.10 below 1.10 it will not support
    dynamodb_table = "test"
    encrypt = true 
  }
}