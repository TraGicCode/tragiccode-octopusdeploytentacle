# Class: octopusdeploytentacle::serv
#
#
class octopusdeploytentacle::service(
  Enum['absent', 'present'] $service_ensure              = $octopusdeploytentacle::params::service_ensure,
  Enum['automatic', 'disabled', 'manual'] $service_state = $octopusdeploytentacle::params::service_state,
  Enum['running', 'stopped'] $service_startuptype        = $octopusdeploytentacle::params::service_startuptype,
) inherits octopusdeploytentacle::params {
    # resources
  dsc_service { 'OctopusDeploy Tentacle':
    dsc_ensure         => $service_ensure,
    dsc_name           => 'OctopusDeploy Tentacle',
    dsc_state          => $service_state,
    dsc_startuptype    => $service_startuptype,
    dsc_builtinaccount => 'LocalSystem',
  }
}