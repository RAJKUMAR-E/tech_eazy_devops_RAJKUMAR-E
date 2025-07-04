#!/bin/bash

ENVIRONMENT=${1:-dev}
ENV_FILE="environments/${ENVIRONMENT}.env"

if [[ ! -f "$ENV_FILE" ]]; then
  echo "❌ Environment file '$ENV_FILE' not found"
  exit 1
fi

echo "🔁 Loading environment from '$ENV_FILE'..."
source "$ENV_FILE"

bash scripts/create_keypair.sh "$TF_VAR_key_name" "$TF_VAR_aws_region"

cd terraform
terraform init
cd ..
set -a
source ./environments/dev.env
set +a
cd terraform
terraform apply -auto-approve
terraform output
