#!/bin/bash

# Specify the AWS region
AWS_REGION=$1

# Filters for Running Instances
RUNNING_FILTERS="Name=instance-state-name,Values=running"

# Filters for All Instances (Running and Stopped)
ALL_FILTERS=""

# Get list of Running EC2 instances
running_instances=$(aws ec2 describe-instances \
  --region $AWS_REGION \
  --filters $RUNNING_FILTERS \
  --query "Reservations[*].Instances[*].[InstanceId,InstanceType,State.Name,Placement.AvailabilityZone,PublicIpAddress,PrivateIpAddress,VpcId,Tags[?Key=='Name'].Value | [0][0],NetworkInterfaces[0].NetworkInterfaceId,IamInstanceProfile.Arn]" \
  --output text)

# Get list of All EC2 instances (Running and Stopped)
all_instances=$(aws ec2 describe-instances \
  --region $AWS_REGION \
  --filters $ALL_FILTERS \
  --query "Reservations[*].Instances[*].[InstanceId,InstanceType,State.Name,Placement.AvailabilityZone,PublicIpAddress,PrivateIpAddress,VpcId,Tags[?Key=='Name'].Value | [0][0],NetworkInterfaces[0].NetworkInterfaceId,IamInstanceProfile.Arn]" \
  --output text)

# Output headers to a single CSV file
echo "InstanceId,InstanceType,InstanceState,AvailabilityZone,PublicIpAddress,PrivateIpAddress,VpcId,TagName,NetworkInterfaceId,IamInstanceProfileArn" > $2

# Loop through each Running EC2 instance and append details to CSV file
while read -r running_instance; do
    echo "$running_instance" | tr '\t' ',' >> $2
done <<< "$running_instances"

# Loop through each All EC2 instance and append details to CSV file
while read -r all_instance; do
    echo "$all_instance" | tr '\t' ',' >> $2
done <<< "$all_instances"

echo "CSV file generated: $2"

