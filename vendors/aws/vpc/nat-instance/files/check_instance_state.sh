#!/bin/bash

# A script to wait for the instance to becoming healthy prior destroying old instance
fail_count=1

while true
do
  instance_status=$(aws ec2 describe-instance-status --instance-id $1 --query "InstanceStatuses[].InstanceStatus.Status" --output text)

  if [[ $instance_status -eq "ok" ]] ; then
    echo "$1 is drinking coffee."
    sleep 30
    echo "$1 is awake!"
    exit 0
  else
    if [ $fail_count -eq 11 ]; then
      echo "$1 went back to bed."
      exit 2
    else
      echo "Attempt ${fail_count}/10: $1 is waking up."
      sleep 3
      fail_count=$[$fail_count +1]
    fi
  fi
done
