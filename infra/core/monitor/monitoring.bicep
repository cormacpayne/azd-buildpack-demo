param logAnalyticsName string
param location string = resourceGroup().location
param tags object = {}

module logAnalytics 'loganalytics.bicep' = {
  name: 'loganalytics'
  params: {
    name: logAnalyticsName
    location: location
    tags: tags
  }
}

output logAnalyticsWorkspaceId string = logAnalytics.outputs.id
output logAnalyticsWorkspaceName string = logAnalytics.outputs.name
