#!/bin/bash

# Specify the AWS region
AWS_REGION=$1

# Get list of Lambda functions
functions=$(aws lambda list-functions --region $AWS_REGION --query "Functions[*].[FunctionName,FunctionArn,Role]" --output text)

# Output headers to CSV file
echo "FunctionName,FunctionArn,Role,AttachedPolicies" > $2

# Loop through each Lambda function and append details to CSV file
while read -r function; do
    function_name=$(echo "$function" | cut -f1)
    function_arn=$(echo "$function" | cut -f2)
    role_arn=$(echo "$function" | cut -f3)
    
    # Get list of attached policies for the role
    attached_policies=$(aws iam list-attached-role-policies --role-name $(basename $role_arn) --region $AWS_REGION --query "AttachedPolicies[*].PolicyName" --output text)
    
    echo "$function_name,$function_arn,$role_arn,\"$attached_policies\"" | tr '\t' ',' >> $2
done <<< "$functions"

echo "CSV file generated: $2"
