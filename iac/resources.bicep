param basename string
param location string

// for avoiding name collision
var uniqueSuffix = substring(uniqueString(resourceGroup().id), 0, 4)

module storage 'modules/storage.bicep' = {
  name: 'st-${basename}-${uniqueSuffix}-deployment'
  params: {
    storageName: 'st${basename}${uniqueSuffix}'
    location: location
  }
}

module registry 'modules/registry.bicep' = {
  name: 'cr-${basename}-${uniqueSuffix}-deployment'
  params: {
    registryName: 'cr${basename}${uniqueSuffix}'
    location: location
  }
}

module vault 'modules/keyvault.bicep' = {
  name: 'kv-${basename}-${uniqueSuffix}-deployment'
  params: {
    vaultName: 'kv${basename}${uniqueSuffix}'
    location: location
  }
}

module insigts 'modules/insights.bicep' = {
  name: 'ai-${basename}-${uniqueSuffix}-deployment'
  params: {
    insightsName: 'ai${basename}${uniqueSuffix}'
    location: location
  }
}

resource aml 'Microsoft.MachineLearningServices/workspaces@2021-07-01' = {
  name: 'mlw-${basename}-${uniqueSuffix}'
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    friendlyName: '${basename}workspace'
    publicNetworkAccess: 'Enabled'
    storageAccount: storage.outputs.storageId
    containerRegistry: registry.outputs.registryId
    keyVault: vault.outputs.vaultId
    applicationInsights: insigts.outputs.insightsId
  }
}

output AML_NAME string = aml.name
output AML_ENDPOINT string = aml.properties.discoveryUrl
output AML_WORKSPACE string = aml.properties.workspaceId
output AML_STORAGE string = aml.properties.storageAccount
output AML_KEYVAULT string = aml.properties.keyVault
