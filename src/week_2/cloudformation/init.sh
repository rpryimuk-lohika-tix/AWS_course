#!/bin/bash
touch SampleTextFile.txt
echo "My sample text file on AWS" > SampleTextFile.txt
aws s3 mb s3://qwerasdfzxcv1234qwer
aws s3api put-bucket-versioning --bucket qwerasdfzxcv1234qwer --versioning-configuration Status=Enabled
aws s3 cp SampleTextFile.txt s3://qwerasdfzxcv1234qwer/