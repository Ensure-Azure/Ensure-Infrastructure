# Infrastructure Architecture

## Overview

The Centinela Infrastructure repository is responsible for defining,
provisioning, validating and destroying the Azure infrastructure required
by the Centinela platform.

The repository follows a layered infrastructure architecture based on:

- Bash
- Azure CLI
- Bicep
- Microsoft Azure

## Architecture

```text
Developer
    |
    v
Bash Scripts
    |
    v
Azure CLI
    |
    v
Bicep
    |
    v
Azure Resource Group
    |
    +---- Storage
    |
    +---- Queue          (Future)
    |
    +---- Identity       (Future)
    |
    +---- Application    (Future)