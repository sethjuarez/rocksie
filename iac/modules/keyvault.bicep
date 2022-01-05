param vaultName string
param location string

resource vault 'Microsoft.KeyVault/vaults@2021-06-01-preview' = {
  name: vaultName
  location: location

  properties: {
    createMode: 'default'
    sku: {
      family: 'A'
      name: 'standard'
    }
    softDeleteRetentionInDays: 7
    tenantId: subscription().tenantId
    accessPolicies: [ ]
  }
}

output vaultId string = vault.id
