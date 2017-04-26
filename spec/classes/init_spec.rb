require 'spec_helper'
describe 'octopusdeploytentacle' do
  context 'with default values for all parameters' do
    it { should contain_class('octopusdeploytentacle') }
    it { should contain_class('octopusdeploytentacle::params') }
    it { should contain_class('octopusdeploytentacle::install').with({
      :communication_mode => 'Listen',
      }) }
  end
end
