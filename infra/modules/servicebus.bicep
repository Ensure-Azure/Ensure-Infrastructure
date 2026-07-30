@description('Service Bus Namespace name')
param serviceBusName string

@description('Azure region')
param location string

@description('Resource tags')
param tags object = {}

resource serviceBus 'Microsoft.ServiceBus/namespaces@2023-01-01-preview' = {

  name: serviceBusName

  location: location

  sku: {
    name: 'Standard'
    tier: 'Standard'
  }

  tags: tags

  properties: {

    minimumTlsVersion: '1.2'

    publicNetworkAccess: 'Enabled'

    zoneRedundant: false

  }

}

resource notificationsQueue 'Microsoft.ServiceBus/namespaces/queues@2023-01-01-preview' = {
  parent: serviceBus
  name: 'notifications'

  properties: {

    maxDeliveryCount: 10

    deadLetteringOnMessageExpiration: true

  }
}

resource processingQueue 'Microsoft.ServiceBus/namespaces/queues@2023-01-01-preview' = {
  parent: serviceBus
  name: 'processing'

  properties: {

    maxDeliveryCount: 10

    deadLetteringOnMessageExpiration: true

  }
}

output serviceBusId string = serviceBus.id

output serviceBusName string = serviceBus.name
