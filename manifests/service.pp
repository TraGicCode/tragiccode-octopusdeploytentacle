# Class: octopusdeploytentacle::serv
#
#
class octopusdeploytentacle::service() {
    # resources
  dsc_service { 'OctopusDeploy Tentacle':
    dsc_name           => 'OctopusDeploy Tentacle',
    dsc_state          => 'Running',
    dsc_startuptype    => 'Automatic',
    dsc_ensure         => 'present',
    dsc_builtinaccount => 'LocalSystem',
  }
}