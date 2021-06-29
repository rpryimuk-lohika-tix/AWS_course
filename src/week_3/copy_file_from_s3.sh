#!/bin/bash
aws s3api get-object --bucket s3-bucket-w-4 --key rds-script.sql rds-script.sql
aws s3api get-object --bucket s3-bucket-w-4 --key dynamodb-script.sh dynamodb-script.sh