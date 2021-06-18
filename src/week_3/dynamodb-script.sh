#!/bin/bash
db=$(aws dynamodb list-tables)
echo $db