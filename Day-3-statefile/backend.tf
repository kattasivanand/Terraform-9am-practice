#terraform {
 # backend "s3" {
  #  bucket         = "my-terraform-state-bucket"   # Replace with your S3 bucket name
   # key            = "dev/ec2/terraform.tfstate"   # Path inside the bucket
    #region         = "us-east-1"                   # AWS Region
    #dynamodb_table = "terraform-lock-table"        # Optional: for state locking
    #encrypt        = true                          # Encrypt the state file
  #}
#}
terraform {
  backend "s3" {
    bucket = "terraformbackendblock"
    key = "day-3/terraform.tfstate"
    region = "us-east-1" 
  }
}