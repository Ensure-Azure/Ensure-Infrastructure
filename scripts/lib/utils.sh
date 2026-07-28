#!/usr/bin/env bash

# Colores for the console
COLOR_RESET="\033[0m"
COLOR_INFO="\033[1;34m"
COLOR_SUCCESS="\033[1;32m"
COLOR_WARN="\033[1;33m"
COLOR_ERROR="\033[1;31m"

log_info() {
    echo -e "${COLOR_INFO}[INFO] ${1}${COLOR_RESET}"
}

log_success() {
    echo -e "${COLOR_SUCCESS}[SUCCESS] ${1}${COLOR_RESET}"
}

log_warn() {
    echo -e "${COLOR_WARN}[WARN] ${1}${COLOR_RESET}"
}

log_error() {
    echo -e "${COLOR_ERROR}[ERROR] ${1}${COLOR_RESET}"
}

check_az_cli() {
    if ! command -v az &> /dev/null; then
        log_error "Azure CLI (az) is not installed. Please install for continue!."
        exit 1
    fi
}

check_az_login() {
    log_info "Verifying active sesion in azure..."
    if ! az account show &> /dev/null; then
        log_warn "There are not an active sesion of azure. Initializing 'az login'..."
        az login --output table
    fi
}