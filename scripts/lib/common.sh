#!/usr/bin/env bash

set -euo pipefail

log_info() {
    echo "[INFO] $1"
}

log_success() {
    echo "[OK] $1"
}

log_warning() {
    echo "[WARNING] $1"
}

log_error() {
    echo "[ERROR] $1" >&2
}

require_command() {
    local command_name="$1"

    if ! command -v "$command_name" &> /dev/null; then
        log_error "Required command not found: $command_name"
        exit 1
    fi
}

require_azure_login() {
    if ! az account show &> /dev/null; then
        log_error "You are not logged into Azure."
        echo ""
        echo "Run:"
        echo "az login"
        exit 1
    fi
}

load_config() {
    local config_file="$1"

    if [[ ! -f "$config_file" ]]; then
        log_error "Configuration file not found:"
        echo "$config_file"
        echo ""
        echo "Create it using:"
        echo "cp config/dev.env.example config/dev.env"
        exit 1
    fi

    source "$config_file"
}

select_subscription() {
    log_info "Selecting Azure subscription..."

    az account set \
        --subscription "$SUBSCRIPTION_ID"

    log_success "Azure subscription selected."
}

require_resource_group() {
    if ! az group show \
        --name "$RESOURCE_GROUP_NAME" \
        &> /dev/null; then

        log_error "Resource Group does not exist:"
        echo "$RESOURCE_GROUP_NAME"

        exit 1
    fi
}