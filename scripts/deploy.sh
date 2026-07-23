#!/usr/bin/env bash

set -euo pipefail

# CENTINELA - DEPLOY SCRIPT

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

CONFIG_FILE="$PROJECT_ROOT/config/dev.env"

# Validate configuration

if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "ERROR: Configuration file not found."
    echo ""
    echo "Create it using:"
    echo "cp config/dev.env.example config/dev.env"
    exit 1
fi

# Load configuration
source "$CONFIG_FILE"

# Validate required variables

required_variables=(
    "SUBSCRIPTION_ID"
    "PROJECT_NAME"
    "ENVIRONMENT"
    "LOCATION"
    "RESOURCE_GROUP_NAME"
)

for variable in "${required_variables[@]}"; do

    if [[ -z "${!variable:-}" ]]; then
        echo "ERROR: Required variable '$variable' is empty."
        exit 1
    fi

done

# Validate Azure CLI

if ! command -v az &> /dev/null; then

    echo "ERROR: Azure CLI is not installed."

    exit 1

fi

# Validate Azure login

if ! az account show &> /dev/null; then

    echo "ERROR: You are not logged into Azure."

    echo ""
    echo "Run:"
    echo "az login"

    exit 1

fi

# Select subscription

echo ""
echo "Selecting Azure subscription..."

az account set \
    --subscription "$SUBSCRIPTION_ID"

# Deployment information

echo ""
echo "=========================================="
echo "CENTINELA INFRASTRUCTURE DEPLOYMENT"
echo "=========================================="

echo "Project:       $PROJECT_NAME"
echo "Environment:   $ENVIRONMENT"
echo "Location:      $LOCATION"
echo "Resource Group: $RESOURCE_GROUP_NAME"

echo ""
echo "=========================================="
echo "DEPLOYMENT STARTED"
echo "=========================================="

# TODO:

echo ""
echo "Infrastructure deployment will be executed here."

echo ""
echo "=========================================="
echo "DEPLOYMENT FINISHED"
echo "=========================================="