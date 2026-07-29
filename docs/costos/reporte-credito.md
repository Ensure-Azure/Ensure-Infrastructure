# Credit Consumption Report — Centinela

**Date:** July 28, 2026 (approx.)

## Current status
- Accumulated spend: $4.64
- Azure forecast: $6.04
- Monthly budget: $60

## Breakdown by resource group
| Resource Group | Spend | Note |
|---|---|---|
| prueba | $4.64 | Test/leftover resources — NOT part of the real Centinela architecture |
| rg-centinela-dev | <$0.01 | Actual Centinela infrastructure — negligible spend so far |

## Checkpoints
| Checkpoint | Target | Actual | Status |
|---|---|---|---|
| End of Week 1 | < $20 USD | $4.64 | Well within target |
| End of Week 2 | < $40 USD | Not reached yet | Pending |
| End of project | < $60 USD | Not reached yet | Pending |

## Key finding
Nearly all current spend ($4.64 of $4.64) comes from the "prueba" resource group, not from actual Centinela infrastructure. This resource group should be deleted to avoid further unnecessary cost, since real project spend is currently negligible.

## Projection
Excluding the "prueba" group, actual Centinela spend is close to $0. At this pace, the project is very likely to stay well under the $60 total budget — provided the "prueba" resources are removed promptly.