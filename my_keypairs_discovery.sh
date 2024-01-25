#!/bin/bash

# Specify the AWS region
AWS_REGION=$1

# Specify the output file
CSV_FILE=$2

# Execute the AWS CLI command and format the output to CSV
aws ec2 describe-key-pairs --region $AWS_REGION | \
    jq -r '["KeyName", "KeyFingerprint"], (.KeyPairs[] | [.KeyName, .KeyFingerprint]) | @csv' > $CSV_FILE

echo "CSV file generated: $CSV_FILE"

