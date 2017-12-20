# Class: octopusdeploytentacle
# ===========================
#
# Full description of class octopusdeploytentacle here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'octopusdeploytentacle':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class octopusdeploytentacle(
  String $server_thumbprint,
  String $instance_pregenerated_certificate,
  String $instance_pregenerated_certificate_thumbprint,
  Stdlib::Httpurl $server_url,
  Pattern[/^API-[a-zA-Z0-9]+$/] $api_key,
  String $environment,
  Array[String] $roles,
  String $public_host_name,
  Enum['present', 'installed', 'absent'] $package_ensure                                    = $octopusdeploytentacle::params::package_ensure,
  Enum['Listen', 'Poll'] $communication_mode                                                = $octopusdeploytentacle::params::communication_mode,
  Stdlib::Absolutepath $instance_home_directory                                             = $octopusdeploytentacle::params::instance_home_directory,
  Stdlib::Absolutepath $instance_application_directory                                      = $octopusdeploytentacle::params::instance_application_directory,
  Stdlib::Absolutepath $instance_pregenerated_certificate_absolute_path                     = $octopusdeploytentacle::params::instance_pregenerated_certificate_absolute_path,
  Integer $instance_port                                                                    = $octopusdeploytentacle::params::instance_port,
  Boolean $manage_service                                                                   = $octopusdeploytentacle::params::manage_service,
  Optional[Enum['absent', 'present']] $service_ensure                                       = $octopusdeploytentacle::params::service_ensure,
  Optional[Enum['running', 'stopped']] $service_state                                       = $octopusdeploytentacle::params::service_state,
  Optional[Enum['automatic', 'disabled', 'manual']] $service_startuptype                    = $octopusdeploytentacle::params::service_startuptype,
  Optional[Enum['localservice', 'localsystem', 'networkservice']] $service_built_in_account = $octopusdeploytentacle::params::service_built_in_account,
  Optional[String] $service_username                                                        = $octopusdeploytentacle::params::service_username,
  Optional[String] $service_password                                                        = $octopusdeploytentacle::params::service_password,
  ) inherits octopusdeploytentacle::params {

  if $service_built_in_account and ($service_username or $service_password) {
    fail('Specify either $builtinaccount or $username and $password, not both')
  }

  class { 'octopusdeploytentacle::install':
    package_ensure     => $package_ensure,
  }

  class { 'octopusdeploytentacle::config':
    communication_mode                              => $communication_mode,
    server_thumbprint                               => $server_thumbprint,
    instance_home_directory                         => $instance_home_directory,
    instance_application_directory                  => $instance_application_directory,
    instance_port                                   => $instance_port,
    instance_pregenerated_certificate               => $instance_pregenerated_certificate,
    instance_pregenerated_certificate_thumbprint    => $instance_pregenerated_certificate_thumbprint,
    instance_pregenerated_certificate_absolute_path => $instance_pregenerated_certificate_absolute_path,
    server_url                                      => $server_url,
    api_key                                         => $api_key,
    environment                                     => $environment,
    roles                                           => $roles,
    public_host_name                                => $public_host_name,
  }
  if ($manage_service) {
      class { 'octopusdeploytentacle::service':
        service_ensure           => $service_ensure,
        service_state            => $service_state,
        service_startuptype      => $service_startuptype,
        service_built_in_account => $service_built_in_account,
        service_username         => $service_username,
        service_password         => $service_password,
    }

    contain octopusdeploytentacle::service

    Class['octopusdeploytentacle::config']
    -> Class['octopusdeploytentacle::service']
  }

  contain octopusdeploytentacle::install
  contain octopusdeploytentacle::config

  Class['octopusdeploytentacle::install']
  -> Class['octopusdeploytentacle::config']
}
