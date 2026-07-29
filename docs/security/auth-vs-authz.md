# Authentication vs. Authorization — Centinela

## Authentication
Authentication answers: "Who are you?" It verifies identity before any action is allowed.

**Example in Centinela:** The API's Service identity authenticates to Azure Storage using Managed Identity — no password is stored or transmitted; Azure confirms the identity behind the scenes.

## Authorization
Authorization answers: "What are you allowed to do?" It happens after identity is confirmed, and checks specific permissions for a specific action.

**Example in Centinela:** After the Service identity is authenticated, Azure checks whether it has write permission on the Blob container. If an attacker somehow got that identity to attempt deleting a resource instead, authentication would succeed (it really is the Service) but authorization would deny the action, since deletion isn't a granted permission.

## Why the distinction matters for this project
A system can have perfect authentication and still be insecure if authorization is too broad — this is exactly why the RBAC matrix (see `rbac.md`) restricts each role to only the specific actions its job requires.