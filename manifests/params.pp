# == Class: octopusdeploytentacle::params
#
class octopusdeploytentacle::params {
  $tentacle_download_url                           = 'http://octopusdeploy.com/downloads/latest/OctopusTentacle64'
  $tentacle_download_absolute_path                 = 'C:\\OctopusTentacle64.msi'
  $instance_pregenerated_certificate_absolute_path = 'C:\\pre-generated-tentacle-certificate.txt'
  $package_ensure                                  = 'present'
  $display_name                                    = $facts['hostname']
  $communication_mode                              = 'Listen'
  $instance_name                                   = 'Tentacle'
  $instance_home_directory                         = 'C:\\Octopus'
  $instance_application_directory                  = 'C:\\Applications'
  $instance_port                                   = 10933
  $manage_service                                  = true
  $service_ensure                                  = 'present'
  $service_state                                   = 'automatic'
  $service_startuptype                             = 'running'
  $service_built_in_account                        = undef
  $service_username                                = undef
  $service_password                                = undef
}
