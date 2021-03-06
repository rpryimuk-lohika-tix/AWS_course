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

resource "aws_instance" "terraform_ddve" {
  ami           = "ami-0800fc0fa715fdcfe"
  instance_type = "t2.micro"
  key_name = "test"
  security_groups = [aws_security_group.allow_tls.name]
  iam_instance_profile = aws_iam_instance_profile.js_ddve_profile.name

  user_data = filebase64("copy_file_from_s3.sh")
}

resource "aws_iam_policy" "js_iam_policy_ddve6_s3" {
  name        = "js_ddve6_iam_policy"
  path        = "/"
  description = "My test policy"

  policy = file("policy_scr.json")
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

  dynamic "ingress" {
    for_each = ["80", "22"]
    content {
    from_port        = ingress.value
    to_port          = ingress.value
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

output "ec2_instance_id" {
  value = aws_instance.terraform_ddve.id
}