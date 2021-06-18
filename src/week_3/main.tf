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
  default = "s3-bucket-w-4"
  description = "Name s3 bucket"
}

//resource "aws_dynamodb_table" "Tree" {
//  name             = "Tree"
//  hash_key         = "TestTableHashKey"
//  billing_mode     = "PAY_PER_REQUEST"
//  stream_enabled   = true
//  stream_view_type = "NEW_AND_OLD_IMAGES"
//
//  attribute {
//    name = "treeId"
//    type = "N"
//  }
//
//  attribute {
//    name = "treeName"
//    type = "S"
//  }
//
//  replica {
//    region_name = "us-west-2"
//  }
//}

//resource "aws_rds_cluster" "postgresql" {
//  cluster_identifier      = "aurora-cluster-demo"
//  engine                  = "aurora-postgresql"
//  availability_zones      = ["us-west-2"]
//  database_name           = "mydb"
//  master_username         = "foo"
//  master_password         = "bar"
//  backup_retention_period = 5
//  preferred_backup_window = "07:00-09:00"
//}

resource "aws_instance" "terraform_ddve" {
  ami           = "ami-0800fc0fa715fdcfe"
  instance_type = "t2.micro"
  key_name = "new_key"
  security_groups = [aws_security_group.allow_tcp.name]
  iam_instance_profile = aws_iam_instance_profile.instance_profile.name

  user_data = templatefile("copy_file_from_s3.tpl", {s3_bucket_name = var.name_s3_bucket})
}

//Permitions----------------

resource "aws_iam_instance_profile" "instance_profile" {

  name = "instance_profile"
  role = aws_iam_role.iam_role.name

  provisioner "local-exec" {
    command = "sleep 20"
  }
}

resource "aws_iam_role" "iam_role" {
  name               = "iam_role"
  assume_role_policy = templatefile("policy_for_iam_role.tpl", {s3_bucket_name = var.name_s3_bucket})
}

resource "aws_iam_policy" "policy" {
  name        = "test_policy"
  path        = "/"
  description = "My test policy"

  policy = templatefile("policy_for_iam_policy.tpl", {s3_bucket_name = var.name_s3_bucket})
}

//---------------------------

resource "aws_security_group" "allow_tcp" {
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

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}