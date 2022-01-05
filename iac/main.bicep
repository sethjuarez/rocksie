targetScope = 'subscription'

@minLength(1)
@maxLength(17)
@description('Prefix for all resources, i.e. {basename}storage')
param basename string

@minLength(1)
@description('Primary location for all resources')
param location string

resource rg 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: '${basename}rg'
  location: location
}

module resources './resources.bicep' = {
  name: '${rg.name}-resources'
  scope: rg
  params: {
    basename: toLower(basename)
    location: location
  }
}

output LOCATION string = location
output WORKSPACE string = resources.outputs.AML_WORKSPACE
