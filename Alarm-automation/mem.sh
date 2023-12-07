#!/bin/bash

INPUT_FILE="input.txt"

ALARMS=(
  "mem_used_percent"
)  # Replace with the list of alarm names you want to create

while IFS=':' read -r INSTANCE_ID NAMESPACE
do
  INSTANCE_NAME=$(aws ec2 describe-instances --instance-ids "$INSTANCE_ID" --query "Reservations[].Instances[].Tags[?Key=='Name'].Value" --output text)
  IP_ADDRESS=$(aws ec2 describe-instances --instance-ids "$INSTANCE_ID" --query "Reservations[].Instances[].PrivateIpAddress" --output text)
  IP_ADDRESS=${IP_ADDRESS//./-}
  for ALARM_NAME in "${ALARMS[@]}"
  do
    ALARM_NAME_WITH_INSTANCE="$INSTANCE_NAME-$ALARM_NAME"
    ALARM_DESCRIPTION="Alarm for $INSTANCE_NAME Instance, Instance IP: $IP_ADDRESS"
    DIMENSIONS="[{\"Name\":\"host\",\"Value\":\"ip-$IP_ADDRESS\"}]"
    aws cloudwatch put-metric-alarm \
      --alarm-name "$ALARM_NAME_WITH_INSTANCE" \
      --alarm-description "$ALARM_DESCRIPTION" \
      --metric-name "$ALARM_NAME" \
      --namespace "$NAMESPACE" \
      --statistic Average \
      --period 300 \
      --evaluation-periods 1 \
      --threshold 60 \
      --comparison-operator GreaterThanOrEqualToThreshold \
      --dimensions "$DIMENSIONS" \
      --alarm-actions "arn:aws:sns:us-west-2:048200214735:prod-sd-alerts"  # Replace with your actual notification ARN
  done
done < "$INPUT_FILE"
