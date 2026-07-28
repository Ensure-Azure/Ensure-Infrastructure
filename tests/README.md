flowchart TD
    Developer[Developer]

    Deploy[deploy.sh]

    CLI[Azure CLI]

    Bicep[main.bicep]

    Azure[Azure]

    RG[Resource Group]

    Storage[Storage Account]

    Developer --> Deploy
    Deploy --> CLI
    CLI --> Bicep
    Bicep --> Azure
    Azure --> RG
    RG --> Storage