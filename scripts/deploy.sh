#!/usr/bin/env bash

# Stop execution if an error occurs
set -e

# Import utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
source "${SCRIPT_DIR}/lib/utils.sh"

log_info "Starting infrastructure deployment process..."

# 1. Load environment variables securely
ENV_FILE="${PROJECT_ROOT}/.env"
if [ -f "$ENV_FILE" ]; then
    log_info "Loading .env configuration file..."
    set -a
    source "$ENV_FILE"
    set +a
else
    log_error "The .env file was not found in the project root."
    log_warn "Copy 'config/dev.env.example' to '.env' in the project root and configure your variables."
    exit 1
fi

# 2. Azure CLI checks
check_az_cli
check_az_login

# 3. Select subscription
log_info "Setting the target subscription: ${AZURE_SUBSCRIPTION_ID}..."
az account set --subscription "$AZURE_SUBSCRIPTION_ID"

# 4. Create the Resource Group if it does not exist
log_info "Verifying/Creating Resource Group '${RESOURCE_GROUP_NAME}' in '${LOCATION}'..."
az group create \
    --name "$RESOURCE_GROUP_NAME" \
    --location "$LOCATION" \
    --output table

# 5. Run Bicep deployment
BICEP_FILE="${PROJECT_ROOT}/infra/main.bicep"

if [ ! -f "$BICEP_FILE" ]; then
    log_error "The main Bicep file was not found at '${BICEP_FILE}'."
    exit 1
fi

log_info "Running the Bicep deployment in Azure..."
az deployment group create \
    --resource-group "$RESOURCE_GROUP_NAME" \
    --template-file "$BICEP_FILE" \
    --parameters \
        projectName="$PROJECT_NAME" \
        environment="$ENVIRONMENT" \
        location="$LOCATION" \
    --output table

log_success "Deployment completed successfully!"