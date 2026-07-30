//==================================================
// PARAMETERS
//==================================================

@description('Managed Identity name')
param identityName string

@description('Azure region')
param location string

@description('Resource tags')
param tags object = {}

//==================================================
// RESOURCE
//==================================================

resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: identityName

  location: location

  tags: tags
}

//==================================================
// OUTPUTS
//==================================================

output identityId string = managedIdentity.id

output principalId string = managedIdentity.properties.principalId

output clientId string = managedIdentity.properties.clientId

output name string = managedIdentity.name
