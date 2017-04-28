# == Class: octopusdeploytentacle::config
#
class octopusdeploytentacle::config(
  String $server_thumbprint,
  String $instance_pregenerated_certificate,
  String $instance_pregenerated_certificate_thumbprint,
  String $instance_name                                = $octopusdeploytentacle::params::instance_name,
  Stdlib::Absolutepath $instance_home_directory        = $octopusdeploytentacle::params::instance_home_directory,
  Stdlib::Absolutepath $instance_application_directory = $octopusdeploytentacle::params::instance_application_directory,
  Enum['Listen', 'Poll']$communication_mode            = $octopusdeploytentacle::params::communication_mode,
  Integer $instance_port                               = $octopusdeploytentacle::params::instance_port,
  ) inherits octopusdeploytentacle::params {
  ## Note: i would like to do something like this but i couldn't get this to work in beaker :(
  # Single quotation marks won't do in that case. You have to add quotation marks around each path and also enclose the whole command in quotation marks:
  # cmd /C ""C:\Program Files (x86)\WinRar\Rar.exe" a "D:\Hello 2\File.rar" "D:\Hello 2\*.*""
  $cli = '"C:\\Program Files\\Octopus Deploy\\Tentacle\\tentacle.exe"'
  $tentacle_config_directory = "${instance_home_directory}\\${instance_name}\\Tentacle.config"
  $tentacle_should_poll = $communication_mode ? {
    'Listen' => false,
    'Poll'   => true,
  }
  $tentacle_pre_generated_certificate_absolute_path = 'C:\\pre-generated-tentacle-certificate.txt'

  # With Find 1 means mastch not found and 0 means match found
  exec { 'create-octopustentacle-instance':
    command   => "C:\\Windows\\System32\\cmd.exe /c \"\"C:\\Program Files\\Octopus Deploy\\Tentacle\\tentacle.exe\" create-instance --instance \"${instance_name}\" --config \"${tentacle_config_directory}\" --console\"",
    creates   => $tentacle_config_directory,
    logoutput => true,
  }
  -> exec { 'create-octopustentacle-home':
    command   => "C:\\Windows\\System32\\cmd.exe /c \"\"C:\\Program Files\\Octopus Deploy\\Tentacle\\tentacle.exe\" configure --instance \"${instance_name}\" --home \"${instance_home_directory}\" --console\"",
    unless    => "C:\\Windows\\System32\\cmd.exe /c \"C:\\Windows\\System32\\findstr.exe \"${instance_home_directory}\" \"${tentacle_config_directory}\"\"",
    logoutput => true,
  }
  -> exec { 'create-octopustentacle-app':
    command   => "C:\\Windows\\System32\\cmd.exe /c \"\"C:\\Program Files\\Octopus Deploy\\Tentacle\\tentacle.exe\" configure --instance \"${instance_name}\" --app \"${instance_application_directory}\" --console\"",
    unless    => "C:\\Windows\\System32\\cmd.exe /c \"C:\\Windows\\System32\\findstr.exe \"${instance_application_directory}\" \"${tentacle_config_directory}\"\"",
    logoutput => true,
  }
  -> exec { 'create-octopustentacle-port':
    command   => "C:\\Windows\\System32\\cmd.exe /c \"\"C:\\Program Files\\Octopus Deploy\\Tentacle\\tentacle.exe\" configure --instance \"${instance_name}\" --port \"${instance_port}\" --console\"",
    unless    => "C:\\Windows\\System32\\cmd.exe /c \"C:\\Windows\\System32\\findstr.exe \"${instance_port}\" \"${tentacle_config_directory}\"\"",
    logoutput => true,
  }
  -> exec { 'create-octopustentacle-communicationmode':
    command   => "C:\\Windows\\System32\\cmd.exe /c \"\"C:\\Program Files\\Octopus Deploy\\Tentacle\\tentacle.exe\" configure --instance \"${instance_name}\" --noListen \"${tentacle_should_poll}\" --console\"",
    unless    => "C:\\Windows\\System32\\cmd.exe /c \"C:\\Windows\\System32\\findstr.exe \"${tentacle_should_poll}\" \"${tentacle_config_directory}\"\"",
    logoutput => true,
  }
  -> exec { 'create-octopustentacle-trust':
    command   => "C:\\Windows\\System32\\cmd.exe /c \"\"C:\\Program Files\\Octopus Deploy\\Tentacle\\tentacle.exe\" configure --instance \"${instance_name}\" --trust \"${server_thumbprint}\" --console\"",
    unless    => "C:\\Windows\\System32\\cmd.exe /c \"C:\\Windows\\System32\\findstr.exe \"${server_thumbprint}\" \"${tentacle_config_directory}\"\"",
    logoutput => true,
  }
  -> file { 'C:\\pre-generated-tentacle-certificate.txt':
    ensure  => file,
    content => $instance_pregenerated_certificate,
  }
  -> exec { 'import-octopustentacle-certificate':
    command   => "C:\\Windows\\System32\\cmd.exe /c \"\"C:\\Program Files\\Octopus Deploy\\Tentacle\\tentacle.exe\" import-certificate --instance \"${instance_name}\" -f C:\\pre-generated-tentacle-certificate.txt  --console\"",
    unless    => "C:\\Windows\\System32\\cmd.exe /c \"C:\\Windows\\System32\\findstr.exe \"${instance_pregenerated_certificate_thumbprint}\" \"${tentacle_config_directory}\"\"",
    logoutput => true,
  }
  -> exec { 'install-and-start-tentacle-service':
    command   => "C:\\Windows\\System32\\cmd.exe /c \"\"C:\\Program Files\\Octopus Deploy\\Tentacle\\tentacle.exe\" service --instance \"${instance_name}\" --install --start --console\"",
    logoutput => true,
  }
}
