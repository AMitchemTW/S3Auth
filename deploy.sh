#!/bin/bash

set -e

aws cloudformation deploy --template-file cloudformation.yml --stack-name S3Auth --capabilities CAPABILITY_NAMED_IAM || echo "All good"

LOGIN_BUCKET_NAME=$(aws cloudformation describe-stack-resource --stack-name S3Auth --logical-resource-id LoginBucket \
 --query StackResourceDetail.PhysicalResourceId --output text)

 PROTECTED_BUCKET_NAME=$(aws cloudformation describe-stack-resource --stack-name S3Auth --logical-resource-id ProtectedBucket \
 --query StackResourceDetail.PhysicalResourceId --output text)

aws s3 sync ./Login/src "s3://$LOGIN_BUCKET_NAME"

aws s3 sync ./Protected/src "s3://$PROTECTED_BUCKET_NAME"