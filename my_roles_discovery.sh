#!/bin/bash

# Specify the AWS region
AWS_REGION=$1

# Get list of IAM roles
roles=$(aws iam list-roles --region $AWS_REGION --query "Roles[*].[RoleName,Arn]" --output text)

# Output headers to CSV file
echo "List of Attached Role Policies" > $2
echo "RoleName,RoleArn,AttachedPolicies" >> $2

# Loop through each IAM role and append details to CSV file
while read -r role; do
    role_name=$(echo "$role" | cut -f1)
    role_arn=$(echo "$role" | cut -f2)
    
    # Get list of attached policies for each role
    # attached_policies=$(aws iam list-attached-role-policies --role-name $role_name --region $AWS_REGION --query "AttachedPolicies[*].PolicyName" --output text)
    attached_policies=$(aws iam list-attached-role-policies --role-name $role_name --region $AWS_REGION --output text)
    
    echo "$role_name,$role_arn,\"$attached_policies\"" | tr '\t' ',' >> $2
done <<< "$roles"

echo $'\n'
echo "List of Roles" >> $2
aws iam list-roles --query 'Roles[*].RoleName' --output table >> $2

echo "CSV file generated: $2"

