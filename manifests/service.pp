# Class: octopusdeploytentacle::serv
#
#
class octopusdeploytentacle::service(
  Enum['absent', 'present'] $service_ensure                                                 = $octopusdeploytentacle::params::service_ensure,
  Enum['automatic', 'disabled', 'manual'] $service_state                                    = $octopusdeploytentacle::params::service_state,
  Enum['running', 'stopped'] $service_startuptype                                           = $octopusdeploytentacle::params::service_startuptype,
  Optional[Enum['localservice', 'localsystem', 'networkservice']] $service_built_in_account = $octopusdeploytentacle::params::service_built_in_account,
  Optional[String] $service_username                                                        = $octopusdeploytentacle::params::service_username,
  Optional[String] $service_password                                                        = $octopusdeploytentacle::params::service_password,
) inherits octopusdeploytentacle::params {


  $service_user_attibutes = $service_built_in_account ? {
  undef   => {
    dsc_credential    => {
      'user'     => $service_username,
      'password' => $service_password,
    }
  },
  default => {
    dsc_builtinaccount => 'LocalSystem'
  }
}

  dsc_service { 'OctopusDeploy Tentacle':
    dsc_ensure      => $service_ensure,
    dsc_name        => 'OctopusDeploy Tentacle',
    dsc_state       => $service_state,
    dsc_startuptype => $service_startuptype,
    *               => $service_user_attibutes,
  }
}