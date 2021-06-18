#!/bin/bash
aws s3api get-object --bucket ${s3_bucket_name} --key rds-script.sql rds-script.sql
aws s3api get-object --bucket ${s3_bucket_name} --key dynamodb-script.sh dynamodb-script.sh