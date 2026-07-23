#!/usr/bin/env bash

set -euo pipefail

# CENTINELA - VERIFY SCRIPT

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

source "$CONFIG_FILE"

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

az account set \
    --subscription "$SUBSCRIPTION_ID"

# Verification

echo ""
echo "=========================================="
echo "CENTINELA INFRASTRUCTURE VERIFICATION"
echo "=========================================="

echo ""
echo "Checking Resource Group..."

if az group show \
    --name "$RESOURCE_GROUP_NAME" \
    &> /dev/null; then

    echo "[OK] Resource Group exists."

else

    echo "[FAIL] Resource Group does not exist."

fi

echo "=========================================="
echo "VERIFICATION FINISHED"
echo "=========================================="