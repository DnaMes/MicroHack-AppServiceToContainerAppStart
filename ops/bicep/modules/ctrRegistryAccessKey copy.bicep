param userAssignedIdentities_as_manId_yovaukoehxbni_name string = 'as-manId-yovaukoehxbni'

resource userAssignedIdentities_as_manId_yovaukoehxbni_name_resource 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-07-31-preview' = {
  name: userAssignedIdentities_as_manId_yovaukoehxbni_name
  location: 'westeurope'
}

resource userAssignedIdentities_as_manId_yovaukoehxbni_name_microhack_identitycredentials 'Microsoft.ManagedIdentity/userAssignedIdentities/federatedIdentityCredentials@2023-07-31-preview' = {
  parent: userAssignedIdentities_as_manId_yovaukoehxbni_name_resource
  name: 'microhack-identitycredentials'
  properties: {
    issuer: 'https://token.actions.githubusercontent.com'
    subject: 'repo:DnaMes/MicroHack-AppServiceToContainerAppStart:ref:refs/heads/main'
    audiences: [
      'api://AzureADTokenExchange'
    ]
  }
}
