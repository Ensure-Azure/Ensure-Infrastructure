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

// App Service Plan
var appServicePlanName = 'asp-${projectName}-${environment}'

// Identity
var managedIdentityName = 'mi-${projectName}-${environment}'

// App Service
var appServiceName = 'app-${projectName}-${environment}'

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
// App Service Plan
//----------------------------

module appServicePlan './modules/appserviceplan.bicep' = {
  name: '${projectName}-appserviceplan'

  params: {
    appServicePlanName: appServicePlanName

    location: location

    tags: {
      Project: projectName
      Environment: environment
      ManagedBy: 'Bicep'
    }
  }
}

//----------------------------
// Managed Identity
//----------------------------

module managedIdentity './modules/managedidentity.bicep' = {

  name: '${projectName}-managedidentity'

  params: {

    identityName: managedIdentityName

    location: location

    tags: {

      Project: projectName

      Environment: environment

      ManagedBy: 'Bicep'

    }

  }

}

//----------------------------
// App Service
//----------------------------

module appService './modules/appservice.bicep' = {

  name: '${projectName}-appservice'

  params: {

    appServiceName: appServiceName

    location: location

    appServicePlanId: appServicePlan.outputs.appServicePlanId

    managedIdentityId: managedIdentity.outputs.identityId

    tags: {

      Project: projectName

      Environment: environment

      ManagedBy: 'Bicep'

    }

  }

}

// Key Vault
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

output appServicePlanId string = appServicePlan.outputs.appServicePlanId

output managedIdentityId string = managedIdentity.outputs.identityId

output managedIdentityPrincipalId string = managedIdentity.outputs.principalId

output appServiceName string = appService.outputs.appServiceName

output appServiceUrl string = appService.outputs.defaultHostName

output keyVaultUri string = keyVault.outputs.keyVaultUri

output storageEndpoint string = storage.outputs.primaryBlobEndpoint

output cosmosEndpoint string = cosmos.outputs.cosmosEndpoint
