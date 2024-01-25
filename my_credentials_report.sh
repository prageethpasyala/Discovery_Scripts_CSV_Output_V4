#!/bin/bash
aws iam generate-credential-report --region $1
aws iam get-credential-report --region $1
# aws iam get-credential-report --region $1 --output text --query Content | base64 -D > $2
# aws iam get-credential-report --region $1 --output text --query Content | base64 -d > $2
aws iam get-credential-report --region $1 --output text --query Content | base64 -d | tr ' ' ',' > $2
