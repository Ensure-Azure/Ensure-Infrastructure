@description('Storage Account name (must be globally unique)')
param storageName string

@description('Azure region')
param location string

@description('Resource tags')
param tags object = {}

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {

  name: storageName

  location: location

  tags: tags

  sku: {
    name: 'Standard_LRS'
  }

  kind: 'StorageV2'

  properties: {

    accessTier: 'Hot'

    supportsHttpsTrafficOnly: true

    minimumTlsVersion: 'TLS1_2'

    allowBlobPublicAccess: false

    allowSharedKeyAccess: false

    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Allow'
    }

  }

}

resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2023-01-01' = {
  parent: storageAccount
  name: 'default'

  properties: {

    isVersioningEnabled: true

    deleteRetentionPolicy: {
      enabled: true
      days: 7
    }

  }
}

resource documentsContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = {

  name: '${storageAccount.name}/default/documents'

  properties: {
    publicAccess: 'None'
  }

}

resource logsContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = {

  name: '${storageAccount.name}/default/logs'

  properties: {
    publicAccess: 'None'
  }

}

output storageAccountId string = storageAccount.id

output storageAccountName string = storageAccount.name

output primaryBlobEndpoint string = storageAccount.properties.primaryEndpoints.blob
