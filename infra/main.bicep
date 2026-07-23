targetScope = 'resourceGroup'

@description('Project name')
param projectName string = 'centinela'

@description('Environment name')
param environment string = 'dev'

var storageAccountName = '${projectName}${environment}storage'

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageAccountName
  location: resourceGroup().location

  sku: {
    name: 'Standard_LRS'
  }

  kind: 'StorageV2'

  properties: {
    accessTier: 'Hot'
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
    supportsHttpsTrafficOnly: true
  }
}
