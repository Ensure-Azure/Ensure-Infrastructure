# Centinela — Real-Time Transaction Fraud Detection

## Overview
Centinela is a fraud detection system for a fintech client, scoring transactions in real time against heuristic rules and opening cases for human review when a score exceeds a configurable threshold.

## Architecture
[Insert Sebas's architecture diagram here WHEN HE HAS DONE]

- **Ingestion API** — receives, validates, and persists transactions (Azure App Service)
- **Storage** — raw transactions and verification documents (Azure Blob Storage)
- **Messaging** — transaction events and case queue (Azure Service Bus)
- **Data stores** — transaction/score history and fraud case management (Azure Cosmos DB) [Week 2]
- **Secrets** — managed via Azure Key Vault, accessed through Managed Identity

## Prerequisites
- Azure subscription with active credit
- Azure CLI installed and authenticated (`az login`)
- Node.js [version] and npm

## Region
**[East US 2]**

## Infrastructure Deployment
1. Clone this repository
2. Run the provisioning script:
```bash
   ./scripts/provision.sh
```
   [Update this once Sebas's actual script exists — path and exact command]
3. Verify resources were created in the Azure Portal under resource group `rg-centinela-dev`

## Application Setup
1. Install dependencies:
```bash
   npm install
```
2. Configure environment (no secrets committed — see Key Vault setup below)
3. Run locally:
```bash
   npm run dev
```

## Secrets Management
All credentials are stored in Azure Key Vault (`kv-centinela-dev`). No connection strings or keys exist in code or environment files. The application authenticates to Key Vault using Managed Identity.

## Shutdown Script
To stop/delete resources consuming credit at the end of a work session:
```bash
./scripts/shutdown.sh
```
[Update once Sebas's script exists]

## Cost Tracking
See `docs/costos/reporte-credito.md` for current spend and budget status.

## Security Documentation
- Roles and permissions matrix: `docs/security/rbac.md`
- Authentication vs. authorization: `docs/security/auth-vs-authz.md`
- Negative access tests: `docs/security/pruebas-negativas.md`

## Project Status
- [x] Week 1 — Infrastructure and ingestion API (in progress)
- [ ] Week 2 — Scoring engine
- [ ] Week 3 — Production, observability, document verification