#!/usr/bin/env bash

# Read-only Azure and Terraform infrastructure audit.
# This script does NOT apply, destroy, start, stop, or create resources.

set -u

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

section() {
  echo
  echo "=================================================="
  echo "$1"
  echo "=================================================="
}

section "1. PROJECT AND GIT STATUS"
echo "Project: $ROOT_DIR"
git -C "$ROOT_DIR" status --short

section "2. ACTIVE AZURE SUBSCRIPTION"
az account show \
  --query "{Subscription:name,SubscriptionId:id,Tenant:tenantId,User:user.name}" \
  -o yaml

section "3. AZURE RESOURCE GROUPS"
az group list \
  --query "[].{Name:name,Location:location,ProvisioningState:properties.provisioningState}" \
  -o table

section "4. ALL AZURE RESOURCES IN THE ACTIVE SUBSCRIPTION"
az resource list \
  --query "[].{Name:name,Type:type,ResourceGroup:resourceGroup,Location:location}" \
  -o table

section "5. AZURE VIRTUAL MACHINES"
az vm list -d \
  --query "[].{Name:name,ResourceGroup:resourceGroup,Location:location,Size:hardwareProfile.vmSize,PowerState:powerState,PrivateIP:privateIps,PublicIP:publicIps}" \
  -o table

section "6. TERRAFORM STATE INVENTORY"

for dir in \
  "$ROOT_DIR/terraform/bootstrap" \
  "$ROOT_DIR/terraform/environments/dev" \
  "$ROOT_DIR/terraform/environments/test" \
  "$ROOT_DIR/terraform/environments/qa" \
  "$ROOT_DIR/terraform/environments/staging" \
  "$ROOT_DIR/terraform/environments/prod"
do
  echo
  echo "---- $(basename "$dir") : $dir ----"

  if [ -d "$dir/.terraform" ]; then
    terraform -chdir="$dir" workspace show
    terraform -chdir="$dir" state list
    if [ $? -ne 0 ]; then
      echo "Could not read this Terraform state. No changes were made."
    fi
  else
    echo "Terraform is not initialized in this directory."
    echo "State inventory skipped; no initialization was attempted."
  fi
done

section "7. LOCAL TERRAFORM STATE AND PLAN FILE NAMES"
find "$ROOT_DIR/terraform" -maxdepth 3 -type f \
  \( -name "*.tfstate" -o -name "*.tfstate.backup" -o -name "*.tfplan" \) \
  -printf '%P\n' 2>/dev/null

section "AUDIT FINISHED"
echo "Read-only checks completed. No Terraform apply or destroy was run."
