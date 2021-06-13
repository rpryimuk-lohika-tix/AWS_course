terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  region  = "us-west-2"
}

variable "name_s3_bucket" {
  type = string
  default = "qwerasdf1234"
}

resource "aws_s3_bucket" "ddve6" {
  bucket = "js-ddve6-bucket"

  versioning {
    enabled = true
  }
}

resource "aws_instance" "terraform_ddve" {
  ami           = "ami-830c94e3"
  instance_type = "t2.micro"

  # key name
  key_name = "new_key"

  # Security group assign to instance
  vpc_security_group_ids = [aws_security_group.allow_tls.id]

  # tighten things up
  iam_instance_profile = aws_iam_instance_profile.js_ddve_profile.name

  user_data = <<-EOT
    aws s3api get-object --bucket qwerasdfzxcv1234qwer --if-match SampleTextFile.txt
  EOT
}

resource "aws_iam_policy" "js_iam_policy_ddve6_s3" {
  name        = "js_ddve6_iam_policy"
  path        = "/"
  description = "My test policy"

  policy = file("policy_scr.json")
  # I do need to have a s3 storage created first
  depends_on = [aws_s3_bucket.ddve6]
}

resource "aws_iam_role_policy_attachment" "assign-policy-to-role-attach" {
  role       = aws_iam_role.js_ec2_s3_access_iam_role.name
  policy_arn = aws_iam_policy.js_iam_policy_ddve6_s3.arn

  depends_on = [aws_iam_policy.js_iam_policy_ddve6_s3]
}

resource "aws_iam_instance_profile" "js_ddve_profile" {

  name = "jd_ddve_profile"
  role = aws_iam_role.js_ec2_s3_access_iam_role.name

  provisioner "local-exec" {
    command = "sleep 20"
  }
}

resource "aws_iam_role" "js_ec2_s3_access_iam_role" {
  name               = "js_ddve6_iam_role"
  assume_role_policy = file("jsrolepolicy.json")
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

output "ec2_instance_id" {
  value = aws_instance.terraform_ddve.id
}

output "S3_bucket_name" {
  value       = aws_s3_bucket.ddve6.bucket
  description = "The value you do need for DDVE configuration on the bucket name!"
}