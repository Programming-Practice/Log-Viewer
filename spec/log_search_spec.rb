require 'spec_helper'

describe LogSearch do

  describe '#search' do
    it 'should return an array containing the correct number of lines' do
      expect(subject.search('TestLogs/test.txt', ['Utilities'] , nil).length).to eq(11)
    end

    it 'should not find any matches for stuff when case is wrong' do
      expect(subject.search('TestLogs/test.txt', ['uTILITIES'], nil).length).to eq(0)
    end

    it 'should print the log does not exist' do
      expect {subject.search('test.txt', ['Utilities'], nil) }.to raise_error IOError
    end

    it 'An operator was not passed for multiple keywords' do
      expect {subject.search('test.txt', ['Utilities', 'ReadRegistry'], nil) }.to raise_error IOError
    end

    it 'should return an array containing the correct number of lines when or operator is used on multiple keywords' do
      expect(subject.search('TestLogs/test.txt', ['SmartQueue','QueueOfMessages'], 'or').length).to eq(3)
    end

    it 'should return an array containing the correct number of lines when and operator is used on multiple keywords' do
      expect(subject.search('TestLogs/test.txt', ['Utilities','ReadRegistry'], 'and').length).to eq(7)
    end


  end

  it 'should return 0 if passed a file with no logs in it' do
    expect(subject.number_of_call_ids('TestLogs/empty_folder/readme.txt')).to equal(0)
  end


  it 'should return the correct number of call IDs' do
    expect(subject.number_of_call_ids('TestLogs/test.txt')).to equal(4)
  end

end
