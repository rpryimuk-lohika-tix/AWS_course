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

data "aws_availability_zone" "available"{
  owners = ["amazon"]
  most_recent = true
  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

variable "name_s3_bucket" {
  type = string
  default = "s3-bucket-w-4"
  description = "Name s3 bucket"
}

resource "aws_dynamodb_table" "Tree" {
  name             = "Tree"
  hash_key         = "treeId"
  range_key      = "treeName"
  billing_mode     = "PROVISIONED"

  attribute {
    name = "treeId"
    type = "N"
  }

  attribute {
    name = "treeName"
    type = "S"
  }

  replica {
    region_name = "us-west-2"
  }
}

resource "aws_db_instance" "postgres_instance" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = postgres
  engine_version         = "12.3"
  instance_class         = "db.t2.micro"
  username               = "foo"
  password               = "123456789"
  vpc_security_group_ids = [aws_security_group.for_db_5432.id]
  skip_final_snapshot    = true
  publicly_accessible    = true
}

resource "aws_instance" "ec2-instance" {
  ami           = "ami-0800fc0fa715fdcfe"
  instance_type = "t2.micro"
  key_name = "new_key"
  security_groups = [aws_security_group.allow_tcp.name]
  iam_instance_profile = aws_iam_instance_profile.instance_profile.name

  user_data = filebase64("copy_file_from_s3.sh")
}

//Permitions----------------

resource "aws_iam_instance_profile" "instance_profile" {
  name = "instance_profile"
  role = aws_iam_role.iam-role.name
}

resource "aws_iam_role" "iam-role" {
  name = "iam-role"
  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
 {
 "Action": "sts:AssumeRole",
 "Principal": {
 "Service": "ec2.amazonaws.com"
 },
 "Effect": "Allow",
 "Sid": ""
 }
 ]
}
 EOF
}

resource "aws_iam_role_policy" "s3_dynamodb_policy" {
  name = "s3_dynamodb_policy"
  role = aws_iam_role.iam-role.id
  policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
 {
 "Effect": "Allow",
 "Action": "s3:*",
 "Resource": "*"
 },
 {
 "Action": [
 "dynamoDb:*"
 ],
 "Effect": "Allow",
 "Resource": "*"
 }
 ]
}
 EOF
}


//---------------------------

resource "aws_security_group" "allow_tcp" {
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

resource "aws_security_group" "for_db_5432" {
  name        = "for_db_5432"

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}