require 'spec_helper'

describe FileHelper do
  let(:subject) { FileHelper.new }

  it 'should get path of the installation location' do
    allow(subject).to receive(:read_vht_registry_for).and_return('vht')
    subject.get_installation_location.should eq('vht')
  end
end
