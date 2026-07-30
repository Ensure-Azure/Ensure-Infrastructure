@description('App Service name')
param appServiceName string

@description('Azure region')
param location string

@description('App Service Plan Id')
param appServicePlanId string

@description('Managed Identity Id')
param managedIdentityId string

@description('Resource tags')
param tags object = {}

@description('App Service subnet')
param subnetId string

@description('Application Insights Connection String')
param applicationInsightsConnectionString string

resource appService 'Microsoft.Web/sites@2023-12-01' = {

  name: appServiceName

  location: location

  kind: 'app,linux'

  tags: tags

  identity: {

    type: 'UserAssigned'

    userAssignedIdentities: {
      '${managedIdentityId}': {}
    }

  }

  properties: {

    serverFarmId: appServicePlanId

    httpsOnly: true

    clientAffinityEnabled: false

    virtualNetworkSubnetId: subnetId
    
    siteConfig: {

      linuxFxVersion: 'NODE|22-lts'

      alwaysOn: false

      ftpsState: 'Disabled'

      http20Enabled: true

      minTlsVersion: '1.2'

      appSettings: [

        {
          name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
          value: applicationInsightsConnectionString
        }

      ]

    }

  }

}


output appServiceId string = appService.id

output appServiceName string = appService.name

output defaultHostName string = appService.properties.defaultHostName
