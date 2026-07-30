@description('Private Endpoint name')
param privateEndpointName string

@description('Azure location')
param location string

@description('Subnet Id')
param subnetId string

@description('Target Resource Id')
param targetResourceId string

@description('Private Link Resource Group')
param groupId string

resource privateEndpoint 'Microsoft.Network/privateEndpoints@2023-09-01' = {

  name: privateEndpointName

  location: location

  properties: {

    subnet: {
      id: subnetId
    }

    privateLinkServiceConnections: [

      {

        name: '${privateEndpointName}-connection'

        properties: {

          privateLinkServiceId: targetResourceId

          groupIds: [
            groupId
          ]

        }

      }

    ]

  }

}

output privateEndpointId string = privateEndpoint.id
