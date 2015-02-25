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
    it 'should return 0 if passed a main output log file with no logs in it' do
      expect(subject.get_number_of_call_ids('TestLogs/empty_folder/readme.txt' , 'MainOutputLog')).to equal(0)
    end

    it 'should return the correct number of call IDs from a populated main output log file' do
      expect(subject.get_number_of_call_ids('TestLogs/test.txt' , 'MainOutputLog')).to equal(4)
    end

    it 'An operator was not passed for multiple keywords' do
      expect {subject.get_number_of_call_ids('TestLogs/test.txt', 'UnknownLog') }.to raise_error IOError
    end

    it 'should return 0 if passed a main report log file with no logs in it' do
      expect(subject.get_number_of_call_ids('TestLogs/empty_folder/readme.txt' , 'MainReportLog')).to equal(0)
    end

    it 'should return the correct number of call IDs from a populated main output log file' do
      expect(subject.get_number_of_call_ids('TestLogs/test.txt' , 'MainReportLog')).to equal(2)
    end

    #TODO pass in something that is not a file, should raise error

  end

end
