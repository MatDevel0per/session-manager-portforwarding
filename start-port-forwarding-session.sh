#!/bin/bash

# Check if the user provided necessary arguments
if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <instance-id> <remote-port> <local-port>"
  exit 1
fi

INSTANCE_ID=$1
REMOTE_PORT=$2
LOCAL_PORT=$3
# Function to start the SSM port forwarding session
start_session() {
  echo "Starting SSM port forwarding session..."
  aws ssm start-session \
    --target $INSTANCE_ID \
    --document-name AWS-StartPortForwardingSession \
    --parameters "portNumber=$REMOTE_PORT,localPortNumber=$LOCAL_PORT"
}

# Infinite loop to keep the session alive
while true; do
  start_session

  echo "SSM session ended. Re-establishing in 5 seconds..."
  sleep 5
done
