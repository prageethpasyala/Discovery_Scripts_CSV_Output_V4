# #!/bin/bash

# # Specify the AWS region
# AWS_REGION=$1

# # Get the start and end dates for the last month
# start_date=$(date -d "$(date '+%Y-%m-01' -d '1 month ago')" '+%Y-%m-%d')
# end_date=$(date -d "$start_date +1 month -1 day" '+%Y-%m-%d')

# # Output CSV file
# output_file=$2

# # Get the cost and usage report for the last month
# aws ce get-cost-and-usage \
#   --time-period "Start=$start_date,End=$end_date" \
#   --granularity MONTHLY \
#   --metrics UsageQuantity \
#   --group-by Type=DIMENSION,Key=SERVICE \
#   --region $AWS_REGION \
#   --output json \
#   | jq -r '.ResultsByTime[].Groups[] | select(.Metrics.UsageQuantity.Amount > 0) | .Keys[0]' \
#   | tr '\t' ',' > "$output_file"

# echo "AWS usage report for $start_date to $end_date has been saved to $output_file"


#!/bin/bash

# Specify the AWS region
AWS_REGION=$1

# Get the start and end dates for the last month
start_date=$(date -d "$(date '+%Y-%m-01' -d '1 month ago')" '+%Y-%m-%d')
end_date=$(date -d "$start_date +1 month -1 day" '+%Y-%m-%d')

# Output CSV file
output_file=$2
echo -e "\n---------------------------UsedServices 1 month ago---------------------------" >> $output_file
# Get the cost and usage report for the last month
aws ce get-cost-and-usage \
  --time-period "Start=$start_date,End=$end_date" \
  --granularity MONTHLY \
  --metrics UsageQuantity \
  --group-by Type=DIMENSION,Key=SERVICE \
  --region $AWS_REGION \
  --output json \
  | jq -r '.ResultsByTime[].Groups[] | select(.Metrics.UsageQuantity.Amount > 0) | .Keys[0]' \
  | tr '\t' ',' > "$output_file"

echo "AWS usage report for $start_date to $end_date has been saved to $output_file"