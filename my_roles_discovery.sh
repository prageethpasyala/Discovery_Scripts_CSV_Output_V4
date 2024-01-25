#!/bin/bash

# Specify the AWS region
AWS_REGION=$1

# Get list of IAM roles
roles=$(aws iam list-roles --region $AWS_REGION --query "Roles[*].[RoleName,Arn]" --output text)

# Output headers to CSV file
echo "List of all managed policies that are attached to a specific IAM role - NOTE: This only displays the first policy if there are multiple policies attached to a role." > $2
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

#======================================original scripts=========================
# Account Policies
echo "List of Account Policies that are attached to local entities (users, groups, or roles)" >> $2
echo "PolicyArn" >> iam_data.csv
aws iam list-policies --scope Local --only-attached --query "Policies[].Arn" --region $1 | jq -r '.[]' >> $2

# Account Roles
echo -e "\nAccount Roles" >> $2
echo "RoleName" >> $2
aws iam list-roles --region $1 | jq -r '.Roles[].RoleName' >> $2

# Role Policies x Account Role
echo -e "\nRole Policies x Account Role" >> $2
echo "RoleName,PolicyName" >> $2
while IFS= read -r role; do
    echo -n "$role," >> $2
    aws iam list-role-policies --role-name $role --region $1 | jq -r '.[]' | tr '\n' ',' | sed 's/,$/\n/' >> $2
done < <(aws iam list-roles --region $1 | jq -r '.Roles[].RoleName')

echo "CSV file generated: $2"