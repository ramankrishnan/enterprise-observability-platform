#!/usr/bin/env bash

set -Eeuo pipefail

# ==========================================
# AEGIS - Terraform DEV Deployment Script
# ==========================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
TERRAFORM_DIR="${PROJECT_ROOT}/terraform/environments/dev"

PLAN_FILE="/tmp/aegis-dev-deployment.tfplan"

echo "=========================================="
echo " AEGIS - DEV Infrastructure Deployment"
echo "=========================================="

# Step 1: Check required commands
for command in terraform az; do
    if ! command -v "$command" >/dev/null 2>&1; then
        echo "ERROR: Required command not found: $command"
        exit 1
    fi
done

# Step 2: Check Azure login
if ! az account show >/dev/null 2>&1; then
    echo "ERROR: Azure CLI login not found."
    echo "Run: az login"
    exit 1
fi

echo
echo "Azure account:"
az account show --query '{Subscription:name, Location:tenantId}' -o table

# Step 3: Check Terraform directory
if [[ ! -d "$TERRAFORM_DIR" ]]; then
    echo "ERROR: Terraform DEV directory not found."
    exit 1
fi

cd "$TERRAFORM_DIR"

# Step 4: Check required variables file
if [[ ! -f "monitoring.auto.tfvars" ]]; then
    echo "ERROR: monitoring.auto.tfvars is missing."
    exit 1
fi

# Step 5: Check SSH public key
SSH_PUBLIC_KEY="${HOME}/.ssh/monitoring_ed25519.pub"

if [[ ! -f "$SSH_PUBLIC_KEY" ]]; then
    echo "ERROR: SSH public key not found:"
    echo "$SSH_PUBLIC_KEY"
    exit 1
fi

echo
echo "[1/5] Formatting Terraform files..."
terraform fmt -recursive

echo
echo "[2/5] Initializing Terraform..."
terraform init -input=false

echo
echo "[3/5] Validating Terraform configuration..."
terraform validate

echo
echo "[4/5] Generating Terraform deployment plan..."
terraform plan \
    -input=false \
    -out="$PLAN_FILE"

echo
echo "=========================================="
echo " Terraform plan generated successfully."
echo " Plan file: $PLAN_FILE"
echo "=========================================="

echo
echo "Review the plan above carefully."
echo "This script will not apply resources without your confirmation."

read -r -p "Type APPLY to create the DEV Azure resources: " APPROVAL

if [[ "$APPROVAL" != "APPLY" ]]; then
    echo
    echo "Deployment cancelled."
    echo "No Terraform apply was executed."
    exit 0
fi

echo
echo "[5/5] Applying the reviewed Terraform plan..."

terraform apply -input=false "$PLAN_FILE"

echo
echo "=========================================="
echo " DEV Terraform deployment completed."
echo "=========================================="

echo
echo "Terraform outputs:"
terraform output
