# #!/bin/bash

# # Function to print CSV header
# print_header() {
#   echo "RoleName,RoleArn,PolicyName"
# }

# # Function to list roles and policies
# list_roles_and_policies() {
#   # Get a list of role names
#   role_names=($(aws iam list-roles --query 'Roles[*].RoleName' --output text))

#   # Iterate through each role
#   for role_name in "${role_names[@]}"; do
#     # Get role ARN
#     role_arn=$(aws iam get-role --role-name "$role_name" --query 'Role.Arn' --output text)

#     # Get policies attached to the role
#     policy_names=($(aws iam list-attached-role-policies --role-name "$role_name" --query 'AttachedPolicies[*].PolicyName' --output text))

#     # Iterate through each policy attached to the role
#     for policy_name in "${policy_names[@]}"; do
#       # Print CSV row
#       echo "$role_name,$role_arn,$policy_name"
#     done
#   done
# }

# # Main script

# # Print CSV header
# print_header

# # List roles and policies
# list_roles_and_policies


#==================================== output.csv
#!/bin/bash

# Account Policies
echo "Account Policies - policies that are attached to local entities (users, groups, or roles)" > iam_data.csv
echo "PolicyArn" >> iam_data.csv
aws iam list-policies --scope Local --only-attached --query "Policies[].Arn" --region $1 | jq -r '.[]' >> iam_data.csv

# Account Roles
echo -e "\nAccount Roles" >> iam_data.csv
echo "RoleName" >> iam_data.csv
aws iam list-roles --region $1 | jq -r '.Roles[].RoleName' >> iam_data.csv

# Role Policies x Account Role
echo -e "\nRole Policies x Account Role" >> iam_data.csv
echo "RoleName,PolicyName" >> iam_data.csv
while IFS= read -r role; do
    echo -n "$role," >> iam_data.csv
    aws iam list-role-policies --role-name $role --region $1 | jq -r '.[]' | tr '\n' ',' | sed 's/,$/\n/' >> iam_data.csv
done < <(aws iam list-roles --region $1 | jq -r '.Roles[].RoleName')

echo "CSV file generated: iam_data.csv"




