# #!/bin/bash

# # Specify the AWS region
# AWS_REGION=$1

# # Ensure region is provided as a command-line argument
# if [ -z "$AWS_REGION" ]; then
#     echo "Usage: $0 <AWS_REGION>"
#     exit 1
# fi

# # Output headers to CSV file
# echo "TransitGatewayId,State,TransitGatewayArn" > $CSV_FILE

# # Get list of EC2-related resources and format the output
# aws ec2 describe-transit-gateways --region $AWS_REGION | \
#     jq -r '["TransitGatewayId", "State", "TransitGatewayArn"], (.TransitGateways[] | [.TransitGatewayId, .State, .TransitGatewayArn]) | @csv' >> $CSV_FILE

# echo "TransitGatewayAttachmentId,ResourceId,ResourceType,State" >> $CSV_FILE
# aws ec2 describe-transit-gateway-attachments --region $AWS_REGION | \
#     jq -r '["TransitGatewayAttachmentId", "ResourceId", "ResourceType", "State"], (.TransitGatewayAttachments[] | [.TransitGatewayAttachmentId, .ResourceId, .ResourceType, .State]) | @csv' >> $CSV_FILE

# echo "TransitGatewayRouteTableId,TransitGatewayId,State" >> $CSV_FILE
# aws ec2 describe-transit-gateway-route-tables --region $AWS_REGION | \
#     jq -r '["TransitGatewayRouteTableId", "TransitGatewayId", "State"], (.TransitGatewayRouteTables[] | [.TransitGatewayRouteTableId, .TransitGatewayId, .State]) | @csv' >> $CSV_FILE

# echo "VpcEndpointId,ServiceName,VpcId,State" >> $CSV_FILE
# aws ec2 describe-vpc-endpoints --region $AWS_REGION | \
#     jq -r '["VpcEndpointId", "ServiceName", "VpcId", "State"], (.VpcEndpoints[] | [.VpcEndpointId, .ServiceName, .VpcId, .State]) | @csv' >> $CSV_FILE

# echo "InternetGatewayId,Attachments" >> $CSV_FILE
# aws ec2 describe-internet-gateways --region $AWS_REGION | \
#     jq -r '["InternetGatewayId", "Attachments"], (.InternetGateways[] | [.InternetGatewayId, (.Attachments | length)]) | @csv' >> $CSV_FILE

# echo "NatGatewayId,State,SubnetId,VpcId" >> $CSV_FILE
# aws ec2 describe-nat-gateways --region $AWS_REGION | \
#     jq -r '["NatGatewayId", "State", "SubnetId", "VpcId"], (.NatGateways[] | [.NatGatewayId, .State, .SubnetId, .VpcId]) | @csv' >> $CSV_FILE

# echo "VpcId,CidrBlock,State" >> $CSV_FILE
# aws ec2 describe-vpcs --region $AWS_REGION | \
#     jq -r '["VpcId", "CidrBlock", "State"], (.Vpcs[] | [.VpcId, .CidrBlock, .State]) | @csv' >> $CSV_FILE

# echo "AvailabilityZoneId,CidrBlock,SubnetId,VpcId" >> $CSV_FILE
# aws ec2 describe-subnets --region $AWS_REGION | \
#     jq -r '["AvailabilityZoneId", "CidrBlock", "SubnetId", "VpcId"], (.Subnets[] | [.AvailabilityZoneId, .CidrBlock, .SubnetId, .VpcId]) | @csv' >> $CSV_FILE

# echo "NetworkAclId,VpcId,Associations" >> $CSV_FILE
# aws ec2 describe-network-acls --region $AWS_REGION | \
#     jq -r '["NetworkAclId", "VpcId", "Associations"], (.NetworkAcls[] | [.NetworkAclId, .VpcId, (.Associations | length)]) | @csv' >> $CSV_FILE

# echo "RouteTableId,VpcId,Routes" >> $CSV_FILE
# aws ec2 describe-route-tables --region $AWS_REGION | \
#     jq -r '["RouteTableId", "VpcId", "Routes"], (.RouteTables[] | [.RouteTableId, .VpcId, (.Routes | length)]) | @csv' >> $CSV_FILE

# echo "GroupId,GroupName,VpcId" >> $CSV_FILE
# aws ec2 describe-security-groups --region $AWS_REGION | \
#     jq -r '["GroupId", "GroupName", "VpcId"], (.SecurityGroups[] | [.GroupId, .GroupName, .VpcId]) | @csv' >> $CSV_FILE

# echo "GroupId,RuleId,CidrIp,FromPort,ToPort,IpProtocol" >> $CSV_FILE
# aws ec2 describe-security-group-rules --region $AWS_REGION | \
#     jq -r '["GroupId", "RuleId", "CidrIp", "FromPort", "ToPort", "IpProtocol"], (.SecurityGroupRules[] | [.GroupId, .RuleId, .CidrIp, .FromPort, .ToPort, .IpProtocol]) | @csv' >> $CSV_FILE

# echo "VpcPeeringConnectionId,AccepterVpcInfo,RequesterVpcInfo" >> $CSV_FILE
# aws ec2 describe-vpc-peering-connections --region $AWS_REGION | \
#     jq -r '["VpcPeeringConnectionId", "AccepterVpcInfo", "RequesterVpcInfo"], (.VpcPeeringConnections[] | [.VpcPeeringConnectionId, .AccepterVpcInfo.VpcId, .RequesterVpcInfo.VpcId]) | @csv' >> $CSV_FILE

# echo "TrafficMirrorFilterId,Description,NetworkServices" >> $CSV_FILE
# aws ec2 describe-traffic-mirror-filters --region $AWS_REGION | \
#     jq -r '["TrafficMirrorFilterId", "Description", "NetworkServices"], (.TrafficMirrorFilters[] | [.TrafficMirrorFilterId, .Description, (.NetworkServices | length)]) | @csv' >> $CSV_FILE

# echo "FlowLogId,ResourceId,ResourceType,TrafficType,LogGroupName" >> $CSV_FILE
# aws ec2 describe-flow-logs --region $AWS_REGION | \
#     jq -r '["FlowLogId", "ResourceId", "ResourceType", "TrafficType", "LogGroupName"], (.FlowLogs[] | [.FlowLogId, .ResourceId, .ResourceType, .TrafficType, .LogGroupName]) | @csv' >> $CSV_FILE

# echo "AllocationId,PublicIp,Domain,InstanceId" >> $CSV_FILE
# aws ec2 describe-addresses --region $AWS_REGION | \
#     jq -r '["AllocationId", "PublicIp", "Domain", "InstanceId"], (.Addresses[] | [.AllocationId, .PublicIp, .Domain, .InstanceId]) | @csv' >> $CSV_FILE

# echo "CSV file generated: $CSV_FILE"



# -====================

#!/bin/bash

# Specify the AWS region
AWS_REGION=$1

# Ensure region is provided as a command-line argument
if [ -z "$AWS_REGION" ]; then
    echo "Usage: $0 <AWS_REGION>"
    exit 1
fi

# Output file
CSV_FILE=$2


# Headers
echo "TransitGateways" > $CSV_FILE
echo "TransitGatewayId,State,TransitGatewayArn" >> $CSV_FILE
aws ec2 describe-transit-gateways --region $AWS_REGION | jq -r '.TransitGateways[] | [.TransitGatewayId, .State, .TransitGatewayArn] | @csv' >> $CSV_FILE

echo -e "\nTransitGatewayAttachments" >> $CSV_FILE
echo "TransitGatewayAttachmentId,ResourceId,ResourceType,State" >> $CSV_FILE
aws ec2 describe-transit-gateway-attachments --region $AWS_REGION | jq -r '.TransitGatewayAttachments[] | [.TransitGatewayAttachmentId, .ResourceId, .ResourceType, .State] | @csv' >> $CSV_FILE

echo -e "\nTransitGatewayRouteTables" >> $CSV_FILE
echo "TransitGatewayRouteTableId,TransitGatewayId,State" >> $CSV_FILE
aws ec2 describe-transit-gateway-route-tables --region $AWS_REGION | jq -r '.TransitGatewayRouteTables[] | [.TransitGatewayRouteTableId, .TransitGatewayId, .State] | @csv' >> $CSV_FILE

echo -e "\nVpcEndpoints" >> $CSV_FILE
echo "VpcEndpointId,ServiceName,VpcId,State" >> $CSV_FILE
aws ec2 describe-vpc-endpoints --region $AWS_REGION | jq -r '.VpcEndpoints[] | [.VpcEndpointId, .ServiceName, .VpcId, .State] | @csv' >> $CSV_FILE

# ... Repeat this pattern for other sections ...
echo -e "\nInternetGateways" >> $CSV_FILE
echo "InternetGatewayId,Attachments" >> $CSV_FILE
# aws ec2 describe-internet-gateways --region $AWS_REGION | \
    # jq -r '["InternetGatewayId", "Attachments"], (.InternetGateways[] | [.InternetGatewayId, (.Attachments | length)]) | @csv' >> $CSV_FILE
aws ec2 describe-internet-gateways --region $AWS_REGION | \
    jq -r '.InternetGateways[] | [.InternetGatewayId, (.Attachments | length)] | @csv' >> $CSV_FILE

echo -e "\nNatGateway" >> $CSV_FILE
echo "NatGatewayId,State,SubnetId,VpcId" >> $CSV_FILE
# aws ec2 describe-nat-gateways --region $AWS_REGION | \
#     jq -r '["NatGatewayId", "State", "SubnetId", "VpcId"], (.NatGateways[] | [.NatGatewayId, .State, .SubnetId, .VpcId]) | @csv' >> $CSV_FILE
aws ec2 describe-nat-gateways --region $AWS_REGION | \
    jq -r '.NatGateways[] | [.NatGatewayId, .State, .SubnetId, .VpcId] | @csv' >> $CSV_FILE

echo -e "\nVpc" >> $CSV_FILE
echo "VpcId,CidrBlock,State" >> $CSV_FILE
# aws ec2 describe-vpcs --region $AWS_REGION | \
#     jq -r '["VpcId", "CidrBlock", "State"], (.Vpcs[] | [.VpcId, .CidrBlock, .State]) | @csv' >> $CSV_FILE
aws ec2 describe-vpcs --region $AWS_REGION | \
    jq -r '.Vpcs[] | [.VpcId, .CidrBlock, .State] | @csv' >> $CSV_FILE

echo -e "\nSubnets" >> $CSV_FILE
echo "AvailabilityZoneId,CidrBlock,SubnetId,VpcId" >> $CSV_FILE
# aws ec2 describe-subnets --region $AWS_REGION | \
#     jq -r '["AvailabilityZoneId", "CidrBlock", "SubnetId", "VpcId"], (.Subnets[] | [.AvailabilityZoneId, .CidrBlock, .SubnetId, .VpcId]) | @csv' >> $CSV_FILE
aws ec2 describe-subnets --region $AWS_REGION | \
    jq -r '.Subnets[] | [.AvailabilityZoneId, .CidrBlock, .SubnetId, .VpcId] | @csv' >> $CSV_FILE

echo -e "\nNetwork-acls" >> $CSV_FILE
echo "NetworkAclId,VpcId,Associations" >> $CSV_FILE
# aws ec2 describe-network-acls --region $AWS_REGION | \
#     jq -r '["NetworkAclId", "VpcId", "Associations"], (.NetworkAcls[] | [.NetworkAclId, .VpcId, (.Associations | length)]) | @csv' >> $CSV_FILE
aws ec2 describe-network-acls --region $AWS_REGION | \
    jq -r '.NetworkAcls[] | [.NetworkAclId, .VpcId, (.Associations | length)] | @csv' >> $CSV_FILE

echo -e "\nRouteTable" >> $CSV_FILE
echo "RouteTableId,VpcId,Routes" >> $CSV_FILE
# aws ec2 describe-route-tables --region $AWS_REGION | \
#     jq -r '["RouteTableId", "VpcId", "Routes"], (.RouteTables[] | [.RouteTableId, .VpcId, (.Routes | length)]) | @csv' >> $CSV_FILE
aws ec2 describe-route-tables --region $AWS_REGION | \
    jq -r '.RouteTables[] | [.RouteTableId, .VpcId, (.Routes | length)] | @csv' >> $CSV_FILE

echo -e "\nSecurity-groups" >> $CSV_FILE
echo "GroupId,GroupName,VpcId" >> $CSV_FILE
# aws ec2 describe-security-groups --region $AWS_REGION | \
#     jq -r '["GroupId", "GroupName", "VpcId"], (.SecurityGroups[] | [.GroupId, .GroupName, .VpcId]) | @csv' >> $CSV_FILE
aws ec2 describe-security-groups --region $AWS_REGION | \
    jq -r '.SecurityGroups[] | [.GroupId, .GroupName, .VpcId] | @csv' >> $CSV_FILE

echo -e "\nSecurity-group-rules" >> $CSV_FILE
echo "GroupId,RuleId,CidrIp,FromPort,ToPort,IpProtocol" >> $CSV_FILE
# aws ec2 describe-security-group-rules --region $AWS_REGION | \
#     jq -r '["GroupId", "RuleId", "CidrIp", "FromPort", "ToPort", "IpProtocol"], (.SecurityGroupRules[] | [.GroupId, .RuleId, .CidrIp, .FromPort, .ToPort, .IpProtocol]) | @csv' >> $CSV_FILE
aws ec2 describe-security-group-rules --region $AWS_REGION | \
    jq -r '.SecurityGroupRules[] | [.GroupId, .RuleId, .CidrIp, .FromPort, .ToPort, .IpProtocol] | @csv' >> $CSV_FILE

echo -e "\nVpcPeering" >> $CSV_FILE
echo "VpcPeeringConnectionId,AccepterVpcInfo,RequesterVpcInfo" >> $CSV_FILE
# aws ec2 describe-vpc-peering-connections --region $AWS_REGION | \
#     jq -r '["VpcPeeringConnectionId", "AccepterVpcInfo", "RequesterVpcInfo"], (.VpcPeeringConnections[] | [.VpcPeeringConnectionId, .AccepterVpcInfo.VpcId, .RequesterVpcInfo.VpcId]) | @csv' >> $CSV_FILE
aws ec2 describe-vpc-peering-connections --region $AWS_REGION | \
    jq -r '.VpcPeeringConnections[] | [.VpcPeeringConnectionId, .AccepterVpcInfo.VpcId, .RequesterVpcInfo.VpcId] | @csv' >> $CSV_FILE

echo -e "\nTrafficMirrorFilter" >> $CSV_FILE
echo "TrafficMirrorFilterId,Description,NetworkServices" >> $CSV_FILE
# aws ec2 describe-traffic-mirror-filters --region $AWS_REGION | \
#     jq -r '["TrafficMirrorFilterId", "Description", "NetworkServices"], (.TrafficMirrorFilters[] | [.TrafficMirrorFilterId, .Description, (.NetworkServices | length)]) | @csv' >> $CSV_FILE
aws ec2 describe-traffic-mirror-filters --region $AWS_REGION | \
    jq -r '.TrafficMirrorFilters[] | [.TrafficMirrorFilterId, .Description, (.NetworkServices | length)] | @csv' >> $CSV_FILE

echo -e "\nFlowLog" >> $CSV_FILE
echo "FlowLogId,ResourceId,ResourceType,TrafficType,LogGroupName" >> $CSV_FILE
# aws ec2 describe-flow-logs --region $AWS_REGION | \
#     jq -r '["FlowLogId", "ResourceId", "ResourceType", "TrafficType", "LogGroupName"], (.FlowLogs[] | [.FlowLogId, .ResourceId, .ResourceType, .TrafficType, .LogGroupName]) | @csv' >> $CSV_FILE
aws ec2 describe-flow-logs --region $AWS_REGION | \
    jq -r '.FlowLogs[] | [.FlowLogId, .ResourceId, .ResourceType, .TrafficType, .LogGroupName] | @csv' >> $CSV_FILE

echo -e "\nAllocatedAddress" >> $CSV_FILE
echo "AllocationId,PublicIp,Domain,InstanceId" >> $CSV_FILE
# aws ec2 describe-addresses --region $AWS_REGION | \
#     jq -r '["AllocationId", "PublicIp", "Domain", "InstanceId"], (.Addresses[] | [.AllocationId, .PublicIp, .Domain, .InstanceId]) | @csv' >> $CSV_FILE
aws ec2 describe-addresses --region $AWS_REGION | \
    jq -r '.Addresses[] | [.AllocationId, .PublicIp, .Domain, .InstanceId] | @csv' >> $CSV_FILE

echo "CSV file generated: $CSV_FILE"


# scriptcsv/746611699916_eu-west-2_network_info.csv

