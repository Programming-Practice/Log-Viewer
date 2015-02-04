require 'spec_helper'

describe VersionParser do

  it 'should return correct version' do
    filename = 'TestLogs/VHLogs/Logs/2015_01_21/Main/09_54_15/MainOutputLog_00001.txt'
    expect(subject.get_version_from_file(filename)).to eq('Version 7, 6, 10, 2943')
  end

  it 'should error if the file is not a main output file' do
    filename = 'TestLogs/VHLogs/Logs/2015_01_21/Main/09_54_15/MainReportLog_00001.txt'
    expect{subject.get_version_from_file(filename)}.to raise_error IOError
  end

  it 'should error if the file does not exist' do
    filename = 'TestLogs/VHLogs/Logs/2015_01_21/Main/09_54_15/MainOutputLog_1232343423423.txt'
    expect{subject.get_version_from_file(filename)}.to raise_error IOError
  end

end