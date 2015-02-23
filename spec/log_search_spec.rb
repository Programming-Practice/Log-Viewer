require 'spec_helper'

describe LogSearch do

  describe '#search' do
    it 'should return an array containing the correct number of lines' do
      expect(subject.search('TestLogs/test.txt', Keyword.new('Utilities')).length).to eq(11)
    end

    it 'should not find any matches for stuff when case is wrong' do
      expect(subject.search('TestLogs/test.txt', Keyword.new('uTILITIES')).length).to eq(0)
    end

    it 'should print the log does not exist' do
      expect {subject.search('test.txt', Keyword.new('Utilities')) }.to raise_error IOError
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
      expect(subject.get_number_of_call_ids('TestLogs/test.txt' , 'MainOutputLog')).to equal(4)
    end

    it 'does a simple search with a keyword' do
      expect(subject.search('TestLogs/test.txt', Keyword.new('Utilities')).length).to eq(11)
    end

    it 'does search for two terms on the same line' do
      expect(subject.search('TestLogs/test.txt', And.new(
                                                            Keyword.new('Utilities'),
                                                            Keyword.new('ReadRegistry'))).length).to eq(7)
    end

    it 'does search for either term on the same line' do
      expect(subject.search('TestLogs/test.txt', Or.new(
                                                            Keyword.new('SmartQueue'),
                                                            Keyword.new('QueueOfMessages'))).length).to eq(3)
    end

    it 'does search for any term from list on the line' do
      expect(subject.search('TestLogs/test.txt',Any.new(
                                                            [Keyword.new('SmartQueue'),
                                                             Keyword.new('QueueOfMessages')])).length).to eq(3)
    end

    it 'does search for all terms in a list on the line' do
      expect(subject.search('TestLogs/test.txt',All.new(
                                                   [Keyword.new('Start'),
                                                    Keyword.new('New Call'),
                                                    Keyword.new('Interaction Created')])).length).to eq(5)
    end

    it 'does a complicated search' do
      expect(subject.search('TestLogs/test.txt',
                                     Or.new(
                                         And.new(
                                             Keyword.new('INFO'),
                                             Keyword.new('Utilities')),
                                         And.new(
                                             Keyword.new('INFO'),
                                             Keyword.new('CVHTCall')))).length).to eq(14)
    end

    it 'should return an array containing the correct number of lines' do
      expect(subject.search('TestLogs/test.txt', Keyword.new('uTILITIES',:insensitive)).length).to eq(11)
    end

    it 'should return an array containing the correct number of lines' do
      expect(subject.search('TestLogs/test.txt', Keyword.new('New Call|Interaction Created',:insensitive)).length).to eq(2)
    end
  end
end
