#!/bin/bash
aws dynamodb list-tables --region us-west-2
#aws dynamodb create-table \
#    --table-name Tree-2021 \
#    --attribute-definitions AttributeName=Id,AttributeType=N AttributeName=Tree_Name,AttributeType=S \
#    --key-schema AttributeName=Id,KeyType=HASH AttributeName=Tree_Name,KeyType=RANGE \
#    --billing-mode PAY_PER_REQUEST
#
#aws dynamodb put-item \
#    --table-name Tree-2021  \
#    --item \
#        '{"Id": {"N": "4"}, "Tree_Name": {"S": "Lipa"}}'
#aws dynamodb put-item \
#    --table-name Tree-2021  \
#    --item \
#        '{"Id": {"N": "2"}, "Tree_Name": {"S": "Kashtan"}}'
#aws dynamodb put-item \
#    --table-name Tree-2021  \
#    --item \
#        '{"Id": {"N": "3"}, "Tree_Name": {"S": "Berezka"}}'
#
#
#aws dynamodb get-item \
#    --table-name Tree-2021 \
#    --key '{"Id": {"N": "2"}, "Tree_Name": {"S": "Kashtan"}}'\
#    --return-consumed-capacity TOTAL
#
#aws dynamodb delete-table --table-name Tree-2021
#aws dynamodb list-tables