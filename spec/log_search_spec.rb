require 'spec_helper'

describe LogSearch do

  describe '#search' do
    it 'should return an array containing the correct number of lines' do
      expect(subject.search('TestLogs/test.txt', 'Utilities').length).to eq(11)
    end

    it 'should not find any matches for stuff when case is wrong' do
      expect(subject.search('TestLogs/test.txt', 'uTILITIES').length).to eq(0)
    end

    it 'should print the log does not exist' do
      expect {subject.search('test.txt', 'Utilities') }.to raise_error IOError
    end
  end

  it 'should return 0 if passed a file with no logs in it' do
    expect(subject.number_of_call_ids('TestLogs/empty_folder/readme.txt')).to equal(0)
  end


  it 'should return the correct number of call IDs' do
    expect(subject.number_of_call_ids('TestLogs/test.txt')).to equal(4)
  end

end
