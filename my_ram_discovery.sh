#!/bin/bash

# Specify the AWS region
AWS_REGION=$1

# Specify the output file
CSV_FILE=$2

# Function to describe RAM resources and append to CSV
function describe_and_append_csv {
    local section_name="$1"
    local query="$2"

    echo -e "\n$section_name" >> $CSV_FILE
    eval "$query" | jq -r --arg section_name "$section_name" \
        '[.[] | [$section_name] + (.[] | to_entries[] | .value)] | @csv' >> $CSV_FILE
}

# Describe RAM resources shared with the account
describe_and_append_csv "RAM_Resources_Shared_With_Account" "aws ram get-resource-shares --region $AWS_REGION --resource-owner OTHER-ACCOUNTS | jq '.' | head"

# List of resources shared with the account
describe_and_append_csv "List_of_Resources_Shared_With_Account" "aws ram list-resources --region $AWS_REGION --resource-owner OTHER-ACCOUNTS | jq '.' | head"

# List of principals sharing resources with the account
describe_and_append_csv "List_of_Principals_Sharing_With_Account" "aws ram list-principals --region $AWS_REGION --resource-owner OTHER-ACCOUNTS | jq '.' | head"

# Separation between sections
echo -e "\n-------------------------ooOOOoo---------------------------" >> $CSV_FILE

# Describe RAM resources shared by the account
describe_and_append_csv "RAM_Resources_Shared_By_Account" "aws ram get-resource-shares --region $AWS_REGION --resource-owner SELF | jq '.' | head"

# List of resources shared by the account
describe_and_append_csv "List_of_Resources_Shared_By_Account" "aws ram list-resources --region $AWS_REGION --resource-owner SELF | jq '.' | head"

# List of principals sharing resources by the account
describe_and_append_csv "List_of_Principals_Sharing_By_Account" "aws ram list-principals --region $AWS_REGION --resource-owner SELF | jq '.' | head"

echo "CSV file generated: $CSV_FILE"

