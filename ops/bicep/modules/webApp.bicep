param webAppServiceName string
param location string
param aspExisting string

resource webAppService_resource 'Microsoft.Web/sites@2024-04-01' = {
  name: webAppServiceName
  location: location
  kind: 'app,linux'
  properties: {
    enabled: true
    hostNameSslStates: [
      {
        name: '${webAppServiceName}.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Standard'
      }
      {
        name: '${webAppServiceName}.scm.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Repository'
      }
    ]
    serverFarmId: aspExisting
    reserved: true
    isXenon: false
    hyperV: false
    dnsConfiguration: {}
    vnetRouteAllEnabled: false
    vnetImagePullEnabled: false
    vnetContentShareEnabled: false
    siteConfig: {
      numberOfWorkers: 1
      linuxFxVersion: 'DOTNETCORE|8.0'
      acrUseManagedIdentityCreds: false
      alwaysOn: false
      http20Enabled: true
      functionAppScaleLimit: 0
      minimumElasticInstanceCount: 0
    }
    scmSiteAlsoStopped: false
    clientAffinityEnabled: true
    clientCertEnabled: false
    clientCertMode: 'Required'
    hostNamesDisabled: false
    ipMode: 'IPv4'
    vnetBackupRestoreEnabled: false
    customDomainVerificationId: '82E4923E60D869150966EA766908FE4AE849462D7D4DC556F33295599AEE5728'
    containerSize: 0
    dailyMemoryTimeQuota: 0
    httpsOnly: false
    endToEndEncryptionEnabled: false
    redundancyMode: 'None'
    storageAccountRequired: false
    keyVaultReferenceIdentity: 'SystemAssigned'
  }
}

resource webAppServiceName_ftp 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2024-04-01' = {
  parent: webAppService_resource
  name: 'ftp'
  properties: {
    allow: false
  }
}

resource webAppServiceName_scm 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2024-04-01' = {
  parent: webAppService_resource
  name: 'scm'
  properties: {
    allow: false
  }
}

resource webAppServiceName_web 'Microsoft.Web/sites/config@2024-04-01' = {
  parent: webAppService_resource
  name: 'web'
  properties: {
    numberOfWorkers: 1
    defaultDocuments: [
      'Default.htm'
      'Default.html'
      'Default.asp'
      'index.htm'
      'index.html'
      'iisstart.htm'
      'default.aspx'
      'index.php'
      'hostingstart.html'
    ]
    netFrameworkVersion: 'v4.0'
    linuxFxVersion: 'DOTNETCORE|8.0'
    requestTracingEnabled: false
    remoteDebuggingEnabled: false
    httpLoggingEnabled: false
    acrUseManagedIdentityCreds: false
    logsDirectorySizeLimit: 35
    detailedErrorLoggingEnabled: false
    publishingUsername: 'REDACTED'
    scmType: 'ExternalGit'
    use32BitWorkerProcess: true
    webSocketsEnabled: false
    alwaysOn: false
    managedPipelineMode: 'Integrated'
    virtualApplications: [
      {
        virtualPath: '/'
        physicalPath: 'site\\wwwroot'
        preloadEnabled: false
      }
    ]
    loadBalancing: 'LeastRequests'
    experiments: {
      rampUpRules: []
    }
    autoHealEnabled: false
    vnetRouteAllEnabled: false
    vnetPrivatePortsCount: 0
    localMySqlEnabled: false
    ipSecurityRestrictions: [
      {
        ipAddress: 'Any'
        action: 'Allow'
        priority: 2147483647
        name: 'Allow all'
        description: 'Allow all access'
      }
    ]
    scmIpSecurityRestrictions: [
      {
        ipAddress: 'Any'
        action: 'Allow'
        priority: 2147483647
        name: 'Allow all'
        description: 'Allow all access'
      }
    ]
    scmIpSecurityRestrictionsUseMain: false
    http20Enabled: true
    minTlsVersion: '1.2'
    scmMinTlsVersion: '1.2'
    ftpsState: 'FtpsOnly'
    preWarmedInstanceCount: 0
    elasticWebAppScaleLimit: 0
    functionsRuntimeScaleMonitoringEnabled: false
    minimumElasticInstanceCount: 0
    azureStorageAccounts: {}
  }
}

resource webAppServiceName_deployment'Microsoft.Web/sites/deployments@2024-04-01' = {
  parent: webAppService_resource
  name: 'ea321129f6bd80f573ae3b17c1beea387096ee95'
  properties: {
    status: 4
    author_email: '110330852+ArneDecker3v08mk@users.noreply.github.com'
    author: 'ArneDecker3v08mk'
    deployer: 'GitHub'
    message: 'Update Index.cshtml'
    start_time: '2025-02-27T09:24:29.1564886Z'
    end_time: '2025-02-27T09:25:01.9830591Z'
    active: true
  }
}

resource webAppServiceName_hostNameBinding 'Microsoft.Web/sites/hostNameBindings@2024-04-01' = {
  parent: webAppService_resource
  name: '${webAppServiceName}.azurewebsites.net'
  properties: {
    siteName: 'hd-webapp-20250227'
    hostNameType: 'Verified'
  }
}

output webAppServiceName string = webAppService_resource.name
output webAppServiceName_defaultHostName string = webAppServiceName_hostNameBinding.name
output webAppServiceName_outboundIpAddresses string = webAppService_resource.properties.outboundIpAddresses
output webAppServiceName_possibleOutboundIpAddresses string = webAppService_resource.properties.possibleOutboundIpAddresses
