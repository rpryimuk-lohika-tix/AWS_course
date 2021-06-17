aws s3api create-bucket --bucket bucket_w4 --region us-west-2
aws s3 cp rds-script.sql s3://bucket_w4
aws s3 cp dynamodb-script.sh s3://bucket_w4