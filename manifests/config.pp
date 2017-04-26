# == Class: octopusdeploytentacle::config
#
class octopusdeploytentacle::config(

  ) inherits octopusdeploytentacle::params {
  ## Note: i would like to do something like this but i couldn't get this to work in beaker :(
  # Single quotation marks won't do in that case. You have to add quotation marks around each path and also enclose the whole command in quotation marks:
  # cmd /C ""C:\Program Files (x86)\WinRar\Rar.exe" a "D:\Hello 2\File.rar" "D:\Hello 2\*.*""
  $cli = '"C:\\Program Files\\Octopus Deploy\\Tentacle\\tentacle.exe"'
  $tentacle_home_directory = 'C:\\Octopus'
  $tentacle_app_directory = 'C:\\Applications'
  $tentacle_config_directory = "${tentacle_home_directory}\\Tentacle\\Tentacle.config"
  # # With Find 1 means mastch not found and 0 means match found
  exec { 'create-octopustentacle-instance':
    command   => "C:\\Windows\\System32\\cmd.exe /c \"\"C:\\Program Files\\Octopus Deploy\\Tentacle\\tentacle.exe\" create-instance --instance Tentacle --config \"${tentacle_config_directory}\" --console\"",
    # unless  => "C:\\Windows\\System32\\cmd.exe /c \"\"C:\\Program Files\\Octopus Deploy\\Tentacle\\tentacle.exe\" list-instances --console | C:\\Windows\\System32\\findstr.exe \"Tentacle\"\"",
    creates   => $tentacle_config_directory,
    logoutput => true,
  }
  ->
  exec { 'create-octopustentacle-home':
    command   => "C:\\Windows\\System32\\cmd.exe /c \"\"C:\\Program Files\\Octopus Deploy\\Tentacle\\tentacle.exe\" configure --instance Tentacle --home \"${tentacle_home_directory}\" --console\"",
    unless    => "C:\\Windows\\System32\\cmd.exe /c \"C:\\Windows\\System32\\findstr.exe \"${tentacle_home_directory}\" \"${tentacle_config_directory}\"\"",
    logoutput => true,
  }
  ->
  exec { 'create-octopustentacle-app':
    command   => "C:\\Windows\\System32\\cmd.exe /c \"\"C:\\Program Files\\Octopus Deploy\\Tentacle\\tentacle.exe\" configure --instance Tentacle --app \"${tentacle_app_directory}\" --console\"",
    unless    => "C:\\Windows\\System32\\cmd.exe /c \"C:\\Windows\\System32\\findstr.exe \"${tentacle_app_directory}\" \"${tentacle_config_directory}\"\"",
    logoutput => true,
  }
}
