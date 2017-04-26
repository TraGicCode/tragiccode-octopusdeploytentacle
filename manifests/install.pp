# == Class: octopusdeploytentacle::install
#
class octopusdeploytentacle::install(
  Enum['present', 'installed', 'absent'] $package_ensure = $octopusdeploytentacle::params::package_ensure,
  Enum['Listen', 'Poll']$communication_mode = $octopusdeploytentacle::params::communication_mode,
  ) inherits octopusdeploytentacle::params {
  $file_ensure = $package_ensure ? {
    'installed' => 'file',
    'present'   => 'file',
    default     => 'absent',
  }
  file { $octopusdeploytentacle::params::tentacle_download_absolute_path:
    ensure => $file_ensure,
    source => $octopusdeploytentacle::params::tentacle_download_url,
  }

  package { 'Octopus Deploy Tentacle':
    ensure => $package_ensure,
    source => $octopusdeploytentacle::params::tentacle_download_absolute_path,
  }
}
