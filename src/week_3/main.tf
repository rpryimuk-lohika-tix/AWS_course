resource "aws_dynamodb_table" "Tree" {
  name             = "Tree"
  hash_key         = "TestTableHashKey"
  billing_mode     = "PAY_PER_REQUEST"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

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

resource "aws_rds_cluster" "postgresql" {
  cluster_identifier      = "aurora-cluster-demo"
  engine                  = "aurora-postgresql"
  availability_zones      = ["us-west-2"]
  database_name           = "mydb"
  master_username         = "foo"
  master_password         = "bar"
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
}

resource "aws_iam_user" "lb" {
  name = "loadbalancer"
  path = "/system/"

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_access_key" "lb" {
  user = aws_iam_user.lb.name
}

resource "aws_iam_user_policy" "lb_ro" {
  name = "test"
  user = aws_iam_user.lb.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_instance" "terraform_ddve" {
  ami           = "ami-0cf6f5c8a62fa5da6"
  instance_type = "t2.micro"
  key_name = "new_key"
  vpc_security_group_ids = [aws_security_group.allow_tcp.id]

  user_data = <<-EOT
    aws s3api get-object --bucket qwerasdfzxcv1234qwer --if-match SampleTextFile.txt
  EOT
}

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
}