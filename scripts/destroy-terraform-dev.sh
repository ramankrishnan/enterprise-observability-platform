
#!/usr/bin/env bash

set -Eeuo pipefail

PROJECT_ROOT="$HOME/enterprise-observability-platform"
TERRAFORM_DIR="$PROJECT_ROOT/terraform/environments/dev"

echo "================================================"
echo " AEGIS - TERRAFORM DEV DESTROY"
echo "================================================"

# 1. Check project directory
if [[ ! -d "$TERRAFORM_DIR" ]]; then
    echo "ERROR: DEV Terraform directory not found."
    exit 1
fi

cd "$TERRAFORM_DIR"

# 2. Check Terraform installation
if ! command -v terraform >/dev/null 2>&1; then
    echo "ERROR: Terraform is not installed."
    exit 1
fi

# 3. Verify Azure CLI and subscription
echo
echo "=== Verifying Azure subscription ==="

if ! command -v az >/dev/null 2>&1; then
    echo "ERROR: Azure CLI is required."
    exit 1
fi

EXPECTED_SUBSCRIPTION="35016cc7-ad9c-4c11-8fa6-e226aed24028"

if ! az account show >/dev/null 2>&1; then
    echo "ERROR: Azure CLI is not logged in."
    exit 1
fi

CURRENT_SUBSCRIPTION=$(az account show --query id -o tsv)

if [[ "$CURRENT_SUBSCRIPTION" != "$EXPECTED_SUBSCRIPTION" ]]; then
    echo "ERROR: Wrong Azure subscription."
    echo "Expected: $EXPECTED_SUBSCRIPTION"
    echo "Current:  $CURRENT_SUBSCRIPTION"
    exit 1
fi

echo "PASS: Correct Azure subscription."
az account show --query '{Name:name,Subscription:id}' -o table
# 4. Initialize Terraform
echo
echo "=== Terraform initialization ==="
terraform init -input=false

# 5. Check workspace
echo
echo "=== Current Terraform workspace ==="

WORKSPACE=$(terraform workspace show)
echo "$WORKSPACE"

if [[ "$WORKSPACE" != "default" ]]; then
    echo "ERROR: Expected default workspace."
    echo "Stopping to prevent destroying the wrong workspace."
    exit 1
fi

# 6. Validate configuration
echo
echo "=== Terraform validation ==="
terraform validate

# 7. Display resources in Terraform state
echo
echo "=== Resources managed by DEV state ==="

if ! terraform state list; then
    echo "ERROR: Unable to read Terraform state."
    exit 1
fi

RESOURCE_COUNT=$(terraform state list | wc -l)

if [[ "$RESOURCE_COUNT" -eq 0 ]]; then
    echo "No resources found in DEV Terraform state."
    exit 0
fi

echo
echo "Total managed resource addresses: $RESOURCE_COUNT"

# 8. Generate destroy plan
PLAN_FILE=$(mktemp /tmp/aegis-dev-destroy.XXXXXX.tfplan)

cleanup() {
    rm -f "$PLAN_FILE"
}

trap cleanup EXIT

echo
echo "=== Generating Terraform destroy plan ==="

terraform plan \
    -destroy \
    -input=false \
    -out="$PLAN_FILE"

# 9. Ask for explicit approval
echo
echo "================================================"
echo " REVIEW THE DESTROY PLAN ABOVE"
echo "================================================"

echo
echo "This operation can permanently delete DEV resources."

read -r -p "Type DESTROY DEV to continue: " CONFIRMATION

if [[ "$CONFIRMATION" != "DESTROY DEV" ]]; then
    echo
    echo "CANCELLED: No resources were destroyed."
    exit 0
fi

# 10. Execute the approved plan
echo
echo "=== Executing approved destroy plan ==="

terraform apply \
    -input=false \
    "$PLAN_FILE"

echo
echo "================================================"
echo " DEV TERRAFORM DESTROY COMPLETED"
echo "================================================"

echo
echo "=== Remaining Terraform resources ==="
terraform state list
