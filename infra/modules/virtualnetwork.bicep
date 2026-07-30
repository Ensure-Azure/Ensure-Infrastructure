@description('Virtual Network name')
param vnetName string

@description('Azure region')
param location string

@description('VNet Address Space')
param addressPrefix string = '10.0.0.0/16'

@description('App Service subnet name')
param appSubnetName string = 'sn-app-service'

@description('App Service subnet prefix')
param appSubnetPrefix string = '10.0.1.0/24'

@description('Private Endpoint subnet name')
param privateSubnetName string = 'sn-private-endpoints'

@description('Private Endpoint subnet prefix')
param privateSubnetPrefix string = '10.0.2.0/24'

@description('Integration subnet name')
param integrationSubnetName string = 'sn-integration'

@description('Integration subnet prefix')
param integrationSubnetPrefix string = '10.0.3.0/24'

resource vnet 'Microsoft.Network/virtualNetworks@2023-09-01' = {
  name: vnetName
  location: location

  properties: {
    addressSpace: {
      addressPrefixes: [
        addressPrefix
      ]
    }

    subnets: [

      {
        name: 'default'
        properties: {
          addressPrefix: '10.0.0.0/24'
        }
      }

      {
        name: appSubnetName
        properties: {
          addressPrefix: appSubnetPrefix

          delegations: [
            {
              name: 'appServiceDelegation'
              properties: {
                serviceName: 'Microsoft.Web/serverFarms'
              }
            }
          ]
        }
      }

      {
        name: privateSubnetName
        properties: {
          addressPrefix: privateSubnetPrefix

          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }

      {
        name: integrationSubnetName
        properties: {
          addressPrefix: integrationSubnetPrefix
        }
      }

    ]
  }
}

output vnetId string = vnet.id

output appServiceSubnetId string ='${vnet.id}/subnets/${appSubnetName}'

output privateEndpointsSubnetId string ='${vnet.id}/subnets/${privateSubnetName}'

output integrationSubnetId string ='${vnet.id}/subnets/${integrationSubnetName}'
