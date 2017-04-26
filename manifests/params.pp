# == Class: octopusdeploytentacle::params
#
class octopusdeploytentacle::params {
  $tentacle_download_url = 'http://octopusdeploy.com/downloads/latest/OctopusTentacle64'
  $communication_mode    = 'Listen'
  $package_ensure        = 'present'
}
