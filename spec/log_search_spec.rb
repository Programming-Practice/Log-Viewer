require 'spec_helper'

describe 'Log search should return correct search results' do

  it 'should return an array containing the correct number of lines' do
    log = LogSearch.new
    expect(log.search('TestLogs/test.txt' , 'Utilities').length).to eq(11)
  end
end

describe 'Log does not exist and should not be found' do

  it 'should print the log does not exist' do
    log = LogSearch.new
    expect {log.search('test.txt' , 'Utilities')}.to raise_error IOError
  end
end
