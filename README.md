# Centinela Infrastructure

This repository contains the Infrastructure as Code (IaC) for the Centinela project on Azure. It uses Bicep templates and Bash scripts to provision, verify, and manage the core Azure resources needed by the application.

## What this IaC does

This project automates the deployment of Azure infrastructure such as:

- Virtual Network
- Key Vault
- Storage Account
- Cosmos DB account

It helps teams create a repeatable and versioned environment for development, testing, and deployment.

---

## Technologies

- Azure CLI
- Bicep
- Bash
- Git
- Azure Resource Manager (ARM) concepts

---

## Prerequisites

Before running the scripts, make sure you have:

- Git
- Azure CLI installed and available in your PATH
- Bash
- An active Azure subscription
- Sufficient permissions to create and manage resources in that subscription

Verify Azure CLI:

```bash
az --version
```

---

## Installation and setup

1. Clone the repository:

```bash
git clone <repository-url>
cd ensure-infrastructure
```

2. Create the environment file from the example:

```bash
cp config/dev.env.example .env
```

3. Edit the values in `.env` to match your Azure subscription and resource naming preferences.

4. Make the scripts executable:

```bash
chmod +x scripts/*.sh
```

---

## Authentication

Sign in to Azure:

```bash
az login
```

Set the target subscription:

```bash
az account set --subscription "<SUBSCRIPTION_ID>"
```

---

## Available commands

Deploy infrastructure:

```bash
./scripts/deploy.sh
```

Verify infrastructure:

```bash
./scripts/verify.sh
```

Destroy infrastructure:

```bash
./scripts/destroy.sh
```

---

## If Bash scripts do not have permission to run

If you get an error like "Permission denied" when running a script, use one of the following options:

```bash
chmod +x scripts/*.sh
```

Or run the script directly with Bash:

```bash
bash ./scripts/deploy.sh
```

If you are using Git Bash or another shell on Windows, the same commands should work as long as Bash is installed.

