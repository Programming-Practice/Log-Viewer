require 'rspec'
require 'version_parser'

describe 'VersionParser' do

  it 'should return correct version' do
    filename = 'TestLogs/VHLogs/Logs/2015_01_21/Main/09_54_15/MainOutputLog_00001.txt'
    parser = VersionParser.new
    parser.get_version_from_file(filename).should == 'Version 7, 6, 10, 2943'
  end
end