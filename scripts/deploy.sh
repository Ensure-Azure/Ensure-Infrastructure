#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

source "$SCRIPT_DIR/lib/common.sh"

CONFIG_FILE="$PROJECT_ROOT/config/dev.env"
BICEP_FILE="$PROJECT_ROOT/infra/main.bicep"

echo "=================================="
echo "CENTINELA INFRASTRUCTURE DEPLOY"
echo "=================================="

require_command az

load_config "$CONFIG_FILE"

require_azure_login

log_info "Selecting Azure subscription..."

az account set \
    --subscription "$SUBSCRIPTION_ID"

log_success "Subscription selected."

log_info "Creating Resource Group..."

az group create \
    --name "$RESOURCE_GROUP_NAME" \
    --location "$LOCATION" \
    --output none

log_success "Resource Group ready."

log_info "Deploying infrastructure..."

az deployment group create \
    --resource-group "$RESOURCE_GROUP_NAME" \
    --template-file "$BICEP_FILE" \
    --parameters \
        projectName="$PROJECT_NAME" \
        environment="$ENVIRONMENT"

log_success "Infrastructure deployed successfully."