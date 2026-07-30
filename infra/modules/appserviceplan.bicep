@description('App Service Plan name')
param appServicePlanName string

@description('Azure region')
param location string

@description('SKU Name')
param skuName string = 'B1'

@description('SKU Tier')
param skuTier string = 'Basic'

@description('Operating System')
param osType string = 'Linux'

@description('Tags')
param tags object = {}


resource appServicePlan 'Microsoft.Web/serverfarms@2023-12-01' = {

  name: appServicePlanName

  location: location

  kind: osType

  tags: tags

  sku: {
    name: skuName
    tier: skuTier
    capacity: 1
  }

  properties: {

    // Linux
    reserved: true

    zoneRedundant: false

    elasticScaleEnabled: false
  }
}


output appServicePlanId string = appServicePlan.id

output appServicePlanName string = appServicePlan.name
