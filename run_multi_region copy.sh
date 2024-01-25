#!/bin/bash

region_scripts() {
    REGION=$1

    echo "Gathering account number"
    echo $'\n'
    ACCOUNT=$(aws sts get-caller-identity --query "Account" | sed 's/"//g')
    echo "ACCOUNT:" $ACCOUNT
    echo "REGION:" $REGION
    mkdir -p Discovery_Reports

    echo $'\n'
    echo "STEP 1 of 9"
    echo "Gathering network information, it make take several minutes, be patient..."
    file1="Discovery_Reports/${ACCOUNT}_${REGION}_network_info.csv"
    echo $file1
    ./my_network_discovery.sh $REGION $file1  

    echo $'\n'
    echo "STEP 2 of 9"
    echo "Gathering Lambda Function information, it make take several minutes, be patient..."
    file2="Discovery_Reports/${ACCOUNT}_${REGION}_lambda_info.csv"
    echo $file2
    ./my_lambda_discovery.sh $REGION $file2 

    echo $'\n'
    echo "STEP 3 of 9"
    echo "Gathering Services information running on the account, it make take several minutes, be patient..."
    file3="Discovery_Reports/${ACCOUNT}_${REGION}_servicesUsed_info.csv"
    echo $file3
    ./my_services_discovery.sh $REGION $file3 

    echo $'\n'
    echo "STEP 4 of 9"
    echo "Gathering Instance information, it make take several minutes, be patient..."
    file4="Discovery_Reports/${ACCOUNT}_${REGION}_Instance_info.csv"
    echo $file4
    ./my_instance_discovery.sh $REGION $file4 

    echo $'\n'
    echo "STEP 5 of 9"
    echo "Gathering KEYs information"
    file5="Discovery_Reports/${ACCOUNT}_${REGION}_KeyPairs_info.csv"
    echo $file5
    ./my_keypairs_discovery.sh $REGION $file5 

    echo $'\n'
    echo "STEP 6 of 9"
    echo "Gathering Roles and Polices, it make take several minutes, be patient..."
    file6="Discovery_Reports/${ACCOUNT}_${REGION}_Roles_Polices.csv"
    echo $file6
    ./my_roles_discovery.sh $REGION $file6 

    echo $'\n'
    echo "STEP 7 of 9"
    echo "Gathering Cloud Stack & StackSets information, it make take several minutes, be patient..."
    file7="Discovery_Reports/${ACCOUNT}_${REGION}_cloudStack_info.csv"
    echo $file7
    ./my_stack_discovery.sh $REGION $file7

    echo $'\n'
    echo "STEP 8 of 9"
    echo "Gathering Resource Sharing information"
    file8="Discovery_Reports/${ACCOUNT}_${REGION}_RAM_info.csv"
    echo $file8
    ./my_ram_discovery.sh $REGION | tee $file8 

    echo $'\n'
    echo "STEP 9 of 9"
    echo "Generating Credentials Report, it make take several minutes, be patient..."
    file9="Discovery_Reports/${ACCOUNT}_${REGION}_credentials_report.csv"
    echo $file9
    ./my_credentials_report.sh $REGION $file9 

    echo $'\n'
    echo "COMPLETED!!!"
}


regions=$(<regions.txt)
echo $regions

for i in ${regions//,/ }
do
  echo "----Region($i)----"
  echo $'\n'
  region_scripts $i
done
