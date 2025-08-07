
# 1. Create IAM Role
resource "aws_iam_role" "ec2_role" {
  name = "example-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

# 2. Attach a policy to the IAM role (example: AmazonS3ReadOnlyAccess)
resource "aws_iam_role_policy_attachment" "attach_s3_policy" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

# 3. Create an Instance Profile
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "example-instance-profile"
  role = aws_iam_role.ec2_role.name
}

# 4. Launch EC2 instance and attach the instance profile
resource "aws_instance" "dev" {
  ami                    = "ami-084a7d336e816906b"
  instance_type          = "t2.micro"
  iam_instance_profile   = aws_iam_instance_profile.ec2_instance_profile.name

  tags = {
    Name = "test"
  }
}
#You cannot attach an IAM Role directly to an EC2 instance.

#You need to wrap the IAM Role inside an IAM Instance Profile.

#Then, the Instance Profile is attached to the EC2 instance.

#Think of it like this:

#IAM Role → wrapped in → IAM Instance Profile → attached to → EC2 instance