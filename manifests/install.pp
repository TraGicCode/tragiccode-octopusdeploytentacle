# == Class: octopusdeploytentacle::install
#
class octopusdeploytentacle::install(
  Enum['Listen', 'Poll']$communication_mode = $octopusdeploytentacle::params::communication_mode,
  ) inherits octopusdeploytentacle::params {


}
