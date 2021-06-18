#!/bin/bash

aws s3 mb s3://$1
aws s3api put-bucket-versioning --bucket $1 --versioning-configuration Status=Enabled
aws s3 cp rds-script.sql s3://$1
aws s3 cp dynamodb-script.sh s3://$1

#/bin/bash /Users/rpryimuk/IdeaProjects/AWS_course/src/week_3/init-s3.sh s3-bucket-w-4