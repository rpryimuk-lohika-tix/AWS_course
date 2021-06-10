variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "ExampleAppServerInstance"
}

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

resource "aws_s3_bucket" "qwerqwer12341234" {
  bucket = "qwerasdf1234"
  acl    = "private"

  versioning {
    enabled = true
  }
}

resource "aws_instance" "qweradsf1234" {
  ami = "ami-830c94e3"
  instance_type = "t2.micro"
  user_data = <<-EOT
    aws s3api get-object --bucket qwerasdfzxcv1234qwer --if-match SampleTextFile.txt
  EOT
}

resource "aws_network_interface_sg_attachment" "sg_attachment" {
  security_group_id    = aws_security_group.allow_tls.id
  network_interface_id = aws_instance.qweradsf1234.primary_network_interface_id
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
    value = aws_instance.qweradsf1234.id
}