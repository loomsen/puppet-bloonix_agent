require 'spec_helper'
describe 'bloonix_agent' do

  context 'with defaults for all parameters' do
    it { should contain_class('bloonix_agent::params') }
  end
end
