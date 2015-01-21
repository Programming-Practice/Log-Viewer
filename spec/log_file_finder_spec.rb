require 'spec_helper'

describe LogFileFinder do

  it 'should return an empty list there are no logs' do
    finder = LogFileFinder.new('TestLogs/empty_folder')
    expect(finder.main_output).to eq([])
  end

  it 'should return a list of five log files when pointed at the five_logs folder' do
    expect(LogFileFinder.new('TestLogs/five_logs').main_output.length).to eq(5)
  end

  it 'should raise an error if directory name does not exist' do
    expect{LogFileFinder.new('does_not_exist')}.to raise_error
  end

  it 'should raise an IOError if the directory name does not exist!' do
    expect { LogFileFinder.new('does_not_exist')}.to raise_error IOError
  end

  it 'should include the requested directory name when raising the error' do
    expect { LogFileFinder.new('does_not_exist')}.to raise_error 'The directory "does_not_exist" does not exist.'
  end
end