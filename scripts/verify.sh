#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

source "$SCRIPT_DIR/lib/common.sh"

CONFIG_FILE="$PROJECT_ROOT/config/dev.env"

echo "=========================================="
echo "    CENTINELA INFRASTRUCTURE VERIFY"
echo "=========================================="
echo ""

# ------------------------------------------
# Requirements
# ------------------------------------------

log_info "Checking required commands..."

require_command az

# ------------------------------------------
# Configuration
# ------------------------------------------

log_info "Loading environment configuration..."

load_config "$CONFIG_FILE"

# ------------------------------------------
# Azure Authentication
# ------------------------------------------

log_info "Checking Azure authentication..."

require_azure_login

# ------------------------------------------
# Azure Subscription
# ------------------------------------------

select_subscription

# ------------------------------------------
# Resource Group
# ------------------------------------------

log_info "Checking Resource Group..."

if az group show \
    --name "$RESOURCE_GROUP_NAME" \
    &> /dev/null; then

    log_success "Resource Group exists."

else

    log_error "Resource Group does not exist:"
    echo "$RESOURCE_GROUP_NAME"

    exit 1
fi

# ------------------------------------------
# Storage Account
# ------------------------------------------

STORAGE_ACCOUNT_NAME="${PROJECT_NAME}${ENVIRONMENT}storage"

log_info "Checking Storage Account..."

if az storage account show \
    --name "$STORAGE_ACCOUNT_NAME" \
    --resource-group "$RESOURCE_GROUP_NAME" \
    &> /dev/null; then

    log_success "Storage Account exists."

else

    log_error "Storage Account does not exist:"
    echo "$STORAGE_ACCOUNT_NAME"

    exit 1
fi

echo ""
echo "=========================================="
echo "Infrastructure verification successful."
echo "=========================================="