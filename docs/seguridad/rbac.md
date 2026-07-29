# Roles and permissios Matrix - Centinela 

## Role: Auditor

| Can do | Resource | Cannot do |
|---|---|---|
|view eerything in the system (transactions, cases, configuration) | Modify anything |

## Role: Analyst 
| Can do | Resource |Cannot do |
|---|---|---|
|Read case details and evidence| case store (cosmos DB) | modify infrastructure configuration |
|Resolve/close a case ( confirm or dismiss fraud) | Case store(cosmos DB) |Create or detele Azure resources |
|Upload verification documents | Storage container (via temporary delegated access) | Access other analysts' unassigned cases outside their scope |


## Role: Administrator
| Can do | Resource | Cannot do | 
|---|---|---|
|configurate detction rules and adjust score thershold | Configuration store (Cosmos DB) | Directly access raw transaction unrelated to configuration |
|Manage risky merchants/categories list | Configuration store (Cosmos DB) | Modify network or infrastructure setting (unless also acting as Cloud admin)|
|Manage application users | Application-level user store | Bypass authentication mechanisms |

## Role: Service
| Can do | Resource |Cannot do | 
|---|---|---|
| Write raw transaction data|Blob Storage|Create new Azure resources|
| Publish transaction event | Queue Storage | Delete existing resources |
| Read recent transaction history for a given account | Transaction store (Cosmos DB) | Authenticate using manually managed credentials (must use Managed Identity) |
| Write score and triggered rule details | Transaction store (Cosmos DB) | Access case management data beyond what's needed to publish a case-opening event |
