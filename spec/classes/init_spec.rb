require 'spec_helper'
describe 'deploy' do

  context 'with defaults for all parameters' do
    it { should contain_class('deploy') }
  end
end
