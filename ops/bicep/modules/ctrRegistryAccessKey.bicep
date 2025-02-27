param managedIdName string
param location string
param userAssIdName string
param registryName string

resource userAssignedIdentities_resource 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-07-31-preview' = {
  name: managedIdName
  location: location
}

resource userAssignedIdentities_microhack_identity_name_userAssignedIdentities_microhack_identity_name 'Microsoft.ManagedIdentity/userAssignedIdentities/federatedIdentityCredentials@2023-07-31-preview' = {
  parent: userAssignedIdentities_resource
  name: userAssIdName
  properties: {
    issuer: 'https://token.actions.githubusercontent.com'
    subject: 'repo:ivmicrohackazdayberlin/MicroHack-AppServiceToContainerAppStart:ref:refs/heads/main'
    audiences: [
      'api://AzureADTokenExchange'
    ]
  }
}
