@description('Application Insights name')
param appInsightsName string

@description('Log Analytics Workspace name')
param workspaceName string

@description('Azure region')
param location string

@description('Tags')
param tags object = {}

resource workspace 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {

  name: workspaceName

  location: location

  tags: tags

  properties: {
    retentionInDays: 30
  }

  sku: {
    name: 'PerGB2018'
  }

}

resource appInsights 'Microsoft.Insights/components@2020-02-02' = {

  name: appInsightsName

  location: location

  kind: 'web'

  tags: tags

  properties: {

    Application_Type: 'web'

    WorkspaceResourceId: workspace.id

  }

}

output applicationInsightsId string = appInsights.id

output applicationInsightsConnectionString string =appInsights.properties.ConnectionString

output logAnalyticsWorkspaceId string =workspace.id
