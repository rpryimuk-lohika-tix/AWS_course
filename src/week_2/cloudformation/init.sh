#!/bin/bash
echo "My sample text file on AWS" > SampleTextFile.txt
aws s3 mb s3://$1
aws s3api put-bucket-versioning --bucket $1 --versioning-configuration Status=Enabled
aws s3 cp SampleTextFile.txt s3://$1/

#./init.sh qwerasdfzxcv1234qwer