param asp string = 'asp'
param appService string = 'webapp'
param ctrRegistry string = 'ctrReg'
param registryName string = 'asctrregyovaukoehxbni'
param managedId string = 'manId'
param location string = resourceGroup().location
// give an unique name to the app service
var appServicePlanName = toLower('as-${asp}-${uniqueString(resourceGroup().id)}')
var appServiceName = toLower('as-${appService}-${uniqueString(resourceGroup().id)}')
var ctrRegistryName = toLower('as${ctrRegistry}${uniqueString(resourceGroup().id)}')
var managedIdentityName = toLower('as${managedId}${uniqueString(resourceGroup().id)}')

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
