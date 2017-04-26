require 'spec_helper'
describe 'octopusdeploytentacle' do
  context 'with default values for all parameters' do
    it { should contain_class('octopusdeploytentacle') }
  end
end
