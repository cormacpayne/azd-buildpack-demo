targetScope = 'subscription'

@minLength(1)
@maxLength(64)
@description('Name of the the environment which is used to generate a short unique hash used in all resources.')
param environmentName string

@minLength(1)
@description('Primary location for all resources')
param location string

param webContainerAppName string = ''

@description('The image name for the web service')
param webImageName string = ''

var abbrs = loadJsonContent('./abbreviations.json')
var resourceToken = toLower(uniqueString(subscription().id, environmentName, location))

// Web frontend
module web './app/web.bicep' = {
  name: 'web'
  scope: resourceGroup('RESOURCE_GROUP_NAME')
  params: {
    name: !empty(webContainerAppName) ? webContainerAppName : '${abbrs.appContainerApps}web-${resourceToken}'
    location: location
    imageName: webImageName
    containerAppsEnvironmentName: 'CONTAINER_APP_ENVIRONMENT_NAME'
    containerRegistryName: 'ACR_NAME'
  }
}

// App outputs
output AZURE_LOCATION string = location
output AZURE_TENANT_ID string = tenant().tenantId
output REACT_APP_WEB_BASE_URL string = web.outputs.SERVICE_WEB_URI
output SERVICE_WEB_NAME string = web.outputs.SERVICE_WEB_NAME
