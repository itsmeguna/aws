#!/bin/bash
SERVERS=(
        "i-0930c36dbc6cd7f9a"
"i-00ce079294164e60c"
"i-0c0ae198521d835c0"
"i-0ae0760da1c910560"
"i-0060445a63c5674be"
"i-09e38089b4e23e5d7"
"i-0e7d75ba70c4afcbb"
"i-0df7126264c5de716"
"i-0eaf6440f5d74937e"
"i-001a021c5c105af8f"
"i-0ddc96ea096eba107"
"i-0fe70b8d027ece709"
"i-0e25a8acc5ac05c36"
"i-06e64bbffd3d8322d"
"i-0e7c9d7ae63a78eda"
"i-04a00014a285a8ce3"
"i-03e56be69712c14a1"
"i-09154e5b11ac0ac6e"
"i-0f5b386fdedf4bd1e"
"i-05d48f9a0ec18824f"
"i-0d5da271d4185274b"
"i-0a8d92706ddfcd87b"
        )

ALARMS=(
  "CPUUtilization"
)

for INSTANCE_ID in "${SERVERS[@]}"
do
  INSTANCE_NAME=$(aws ec2 describe-instances --instance-ids "$INSTANCE_ID" --query "Reservations[].Instances[].Tags[?Key=='Name'].Value" --output text)
  IP_ADDRESS=$(aws ec2 describe-instances --instance-ids "$INSTANCE_ID" --query "Reservations[].Instances[].PrivateIpAddress" --output text)
  for ALARM_NAME in "${ALARMS[@]}"
  do
    ALARM_NAME_WITH_INSTANCE="$INSTANCE_NAME-$ALARMS"
    ALARM_DESCRIPTION="Alarm for  $INSTANCE_NAME , Instance IP: $IP_ADDRESS"
    aws cloudwatch put-metric-alarm \
      --alarm-name "$ALARM_NAME_WITH_INSTANCE" \
      --alarm-description "$ALARM_DESCRIPTION" \
      --metric-name "$ALARM_NAME" \
      --namespace "AWS/EC2" \
      --statistic Average \
      --period 300 \
      --evaluation-periods 1 \
      --threshold 60 \
      --comparison-operator  GreaterThanOrEqualToThreshold \
      --dimensions "Name=InstanceId,Value=$INSTANCE_ID" \
      --alarm-actions "arn:aws:sns:us-west-2:048200214735:prod-sd-alerts"
  done
done
