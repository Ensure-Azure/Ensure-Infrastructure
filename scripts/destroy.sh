#!/usr/bin/env bash

set -euo pipefail

# CENTINELA - DESTROY SCRIPT

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

CONFIG_FILE="$PROJECT_ROOT/config/dev.env"

# Validate configuration

if [[ ! -f "$CONFIG_FILE" ]]; then

    echo "ERROR: Configuration file not found."

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

# Confirmation

echo "WARNING"

echo "You are about to delete:"
echo ""
echo "Resource Group: $RESOURCE_GROUP_NAME"
echo ""

read -r -p "Type 'DELETE' to continue: " confirmation

if [[ "$confirmation" != "DELETE" ]]; then

    echo ""
    echo "Operation cancelled."

    exit 0

fi

# Destroy

echo ""
echo "Deleting Resource Group..."

az group delete \
    --name "$RESOURCE_GROUP_NAME" \
    --yes

echo "DESTRUCTION FINISHED"