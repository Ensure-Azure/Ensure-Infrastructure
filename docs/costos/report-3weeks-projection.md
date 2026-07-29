# Credit Consumption Report — Centinela

**Date:** July 28, 2026

## Current status
- Accumulated spend: $4.64
- Azure forecast (short-term): $6.04
- Monthly budget configured: $60

## Breakdown by resource group
| Resource Group | Spend | Note |
|---|---|---|
| prueba | $4.64 | Leftover/test resources — not part of Centinela's real architecture |
| rg-centinela-dev | <$0.01 | Actual Centinela infrastructure |

## Known infrastructure (rg-centinela-dev)
| Resource | Type | Region |
|---|---|---|
| cosmos-centinela-dev | Cosmos DB | West US 2 |
| kv-centinela-dev | Key Vault | West US 2 |
| sb-centinela-dev | Service Bus | West US 2 |
| stcentineladev01 | Storage account | East US 2 |
| vr-centinela-dev | Virtual network | East US 2 |

**Open issue:** resources are split across two regions (West US 2 and East US 2). This needs resolution before proceeding further — it affects network isolation design (a private VNet in one region cannot easily reach resources in another without extra cost/complexity).

## Checkpoints vs. targets
| Checkpoint | Target | Actual | Status |
|---|---|---|---|
| End of Week 1 | < $20 USD | $4.64 | Within target |
| End of Week 2 | < $40 USD | Not reached yet | Projected safe if "prueba" is removed |
| End of project (Week 3) | < $60 USD | Not reached yet | Projected safe if "prueba" is removed |

## 3-Week Projection

**Scenario A — "prueba" resource group is deleted this week (recommended):**
Real Centinela spend is currently near $0. Even accounting for Cosmos DB, Service Bus, and Function/App Service usage ramping up in weeks 2-3, projected total spend by project end is estimated well under $60, likely in the $15-30 range.

**Scenario B — "prueba" is left running (not recommended):**
At ~$4.64/week of unnecessary spend from a single leftover VM setup, three more weeks would add roughly $14-20 on top of real project costs — still likely under budget, but with zero benefit and unnecessary risk of hitting quota limits sooner.

## Recommendation
Delete the "prueba" resource group immediately. It contributes 100% of current spend with zero function in the actual Centinela architecture, and its continued existence needlessly consumes both budget and Azure quota that the project may need in weeks 2-3.