#!/bin/bash
KEY_NAME=$1
REGION=$2
PEM_FILE="${KEY_NAME}.pem"

if [ -f "$PEM_FILE" ]; then
  echo "🔐 Key file '$PEM_FILE' already exists. Skipping creation."
else
  echo "🛠️  Creating key pair '$KEY_NAME' in region '$REGION'..."
  aws ec2 create-key-pair \
    --key-name "$KEY_NAME" \
    --query "KeyMaterial" \
    --region "$REGION" \
    --output text > "$PEM_FILE"

  chmod 400 "$PEM_FILE"
  echo "✅ Key saved as '$PEM_FILE'"
fi
