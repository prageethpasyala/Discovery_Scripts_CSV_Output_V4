#!/bin/bash

# Specify the AWS region
AWS_REGION=$1

# Get list of CloudFormation stacks in the specified region
stacks=$(aws cloudformation list-stacks --region $AWS_REGION --query "StackSummaries[*].[StackName,StackStatus]" --output text)

# Get list of Stack Sets in the specified region
stack_sets=$(aws cloudformation list-stack-sets --region $AWS_REGION --query "Summaries[*].[StackSetName,Status]" --output text)

# Output headers to CSV file
echo "StackName,StackStatus,Type" > $2

# Loop through each stack and append details to CSV file
while read -r stack; do
    echo "$stack,Stack" | tr '\t' ',' >> $2
done <<< "$stacks"

# Loop through each stack set and append details to CSV file
while read -r stack_set; do
    echo "$stack_set,StackSet" | tr '\t' ',' >> $2
done <<< "$stack_sets"

echo "CSV file generated: $2.csv"

