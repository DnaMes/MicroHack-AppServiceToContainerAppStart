param location string = resourceGroup().location // location of the resources

// WebApp
param asp string = 'asp' // app service plan
param appService string = 'webapp' // web app

// Container Registry
param ctrRegistry string = 'ctrReg' // container registry
// Managed ID
param managedId string = 'manId' // managed identity
param federedCredential string = 'microhack-identitycredentials' // federated credential for container registry
// give an unique name to the app service
var appServicePlanName = toLower('as-${asp}-${uniqueString(resourceGroup().id)}')
var appServiceName = toLower('as-${appService}-${uniqueString(resourceGroup().id)}')
var ctrRegistryName = toLower('as${ctrRegistry}${uniqueString(resourceGroup().id)}')
var managedIdentityName = toLower('as-${managedId}-${uniqueString(resourceGroup().id)}')

module appServicePlanModule './modules/appservicePlan.bicep' = {
  name: '${appServicePlanName}-Deployment'
  params: {
    aspName: appServicePlanName
    location: location
  }
}

module webAppModule './modules/webApp.bicep' = {
  name: '${appServiceName}-Deployment'
  params: {
    location: location
    aspExisting: appServicePlanModule.outputs.aspResourceId
    webAppServiceName: appServiceName
  }
}

module containerRegistryModule './modules/containerRegistry.bicep' = {
  name: '${ctrRegistryName}-Deployment'
  params: {
    containerRegistryName: ctrRegistryName
    location: location
  }
}

module ctrRegistryAccessKeyModule './modules/ctrRegistryAccessKey.bicep' = {
  name: '${managedIdentityName}-Deployment'
  params: {
    managedIdName: managedIdentityName
    location: location
    federalCredential: federedCredential
  }
}
