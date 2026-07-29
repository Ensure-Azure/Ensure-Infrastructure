@description('Project name')
param projectName string = 'centinela'

@description('Deployment environment (dev, staging, prod)')
param environment string = 'dev'

@description('Azure region')
param location string = 'westus2'

var vnetName = 'vr-${projectName}-${environment}'
var keyVaultName = 'kv-${projectName}-${environment}'
var storageName = 'st${projectName}${environment}1'
var cosmosName = 'cosmos-${projectName}-${environment}'

module vnetModule './modules/virtualnetwork.bicep' = {
  name: 'vnetDeployment'
  params: {
    vnetName: vnetName
    location: location
  }
}

module keyVaultModule './modules/keyvault.bicep' = {
  name: 'keyVaultDeployment'
  params: {
    keyVaultName: keyVaultName
    location: location
  }
}

module storageModule './modules/storage.bicep' = {
  name: 'storageDeployment'
  params: {
    storageName: storageName
    location: location
  }
}

module cosmosModule './modules/cosmos.bicep' = {
  name: 'cosmosDeployment'
  params: {
    cosmosName: cosmosName
    location: location
  }
}

output vnetId string = vnetModule.outputs.vnetId
output keyVaultUri string = keyVaultModule.outputs.keyVaultUri
output storageBlobEndpoint string = storageModule.outputs.primaryBlobEndpoint
output cosmosEndpoint string = cosmosModule.outputs.cosmosEndpoint
