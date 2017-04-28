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
  Stromg $instance_pregenerated_certificate_thumbprint,
  Enum['present', 'installed', 'absent'] $package_ensure = $octopusdeploytentacle::params::package_ensure,
  Enum['Listen', 'Poll']$communication_mode              = $octopusdeploytentacle::params::communication_mode,
  Stdlib::Absolutepath $instance_home_directory          = $octopusdeploytentacle::params::instance_home_directory,
  Stdlib::Absolutepath $instance_application_directory   = $octopusdeploytentacle::params::instance_application_directory,
  Integer $instance_port                                 = $octopusdeploytentacle::params::instance_port,
  ) inherits octopusdeploytentacle::params {

  class { 'octopusdeploytentacle::install':
    package_ensure     => $package_ensure,
  }

  class { 'octopusdeploytentacle::config':
    communication_mode                           => $communication_mode,
    server_thumbprint                            => $server_thumbprint,
    instance_home_directory                      => $instance_home_directory,
    instance_application_directory               => $instance_application_directory,
    instance_port                                => $instance_port,
    instance_pregenerated_certificate            => $instance_pregenerated_certificate,
    instance_pregenerated_certificate_thumbprint => $instance_pregenerated_certificate_thumbprint,
  }

  Class['octopusdeploytentacle::install']
  -> Class['octopusdeploytentacle::config']
}
