//==================================================
// PARAMETERS
//==================================================

@description('Project name')
param projectName string = 'centinela'

@description('Deployment environment')
param environment string = 'dev'

@description('Azure region')
param location string = 'westus2'


//==================================================
// VARIABLES
//==================================================

// Network
var vnetName = 'vr-${projectName}-${environment}'

// Storage
var storageName = 'st${projectName}${environment}01'

// Security
var keyVaultName = 'kv-${projectName}-${environment}'

// Database
var cosmosName = 'cosmos-${projectName}-${environment}'


//==================================================
// MODULES
//==================================================

//----------------------------
// Virtual Network
//----------------------------

module network './modules/virtualnetwork.bicep' = {
  name: '${projectName}-network'

  params: {
    vnetName: vnetName
    location: location
  }
}

//----------------------------
// Key Vault
//----------------------------

module keyVault './modules/keyvault.bicep' = {
  name: '${projectName}-keyvault'

  params: {
    keyVaultName: keyVaultName
    location: location
  }
}

//----------------------------
// Storage Account
//----------------------------

module storage './modules/storage.bicep' = {
  name: '${projectName}-storage'

  params: {
    storageName: storageName
    location: location
  }
}

//----------------------------
// Cosmos DB
//----------------------------

module cosmos './modules/cosmos.bicep' = {
  name: '${projectName}-cosmos'

  params: {
    cosmosName: cosmosName
    location: location
  }
}


//==================================================
// OUTPUTS
//==================================================

output vnetId string = network.outputs.vnetId

output keyVaultUri string = keyVault.outputs.keyVaultUri

output storageEndpoint string = storage.outputs.primaryBlobEndpoint

output cosmosEndpoint string = cosmos.outputs.cosmosEndpoint
