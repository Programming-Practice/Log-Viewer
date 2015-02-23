require 'spec_helper'

shared_examples :search_engine do

  describe '#search' do
    it 'should return an array containing the correct number of lines' do
      expect(subject.search('TestLogs/test.txt', described_class.new('Utilities')).length).to eq(11)
    end

    it 'should not find any matches for stuff when case is wrong' do
      expect(subject.search('TestLogs/test.txt', described_class.new('uTILITIES')).length).to eq(0)
    end

    it 'should print the log does not exist' do
      expect {subject.search('test.txt', described_class.new('Utilities')) }.to raise_error IOError
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
      expect(subject.search('TestLogs/test.txt', described_class.new('Utilities')).length).to eq(11)
    end

    it 'does search for two terms on the same line' do
      expect(subject.search('TestLogs/test.txt', And.new(
        described_class.new('Utilities'),
        described_class.new('ReadRegistry'))).length).to eq(7)
    end

    it 'does search for either term on the same line' do
      expect(subject.search('TestLogs/test.txt', Or.new(
        described_class.new('SmartQueue'),
        described_class.new('QueueOfMessages'))).length).to eq(3)
    end

    it 'does search for any term from list on the line' do
      expect(subject.search('TestLogs/test.txt',Any.new(
        [described_class.new('SmartQueue'),
         described_class.new('QueueOfMessages')])).length).to eq(3)
    end

    it 'does search for all terms in a list on the line' do
      expect(subject.search('TestLogs/test.txt',All.new(
        [described_class.new('Start'),
         described_class.new('New Call'),
         described_class.new('Interaction Created')])).length).to eq(5)
    end

    it 'does a complicated search' do
      expect(subject.search('TestLogs/test.txt',
                            Or.new(
                              And.new(
                                described_class.new('INFO'),
                                described_class.new('Utilities')),
                              And.new(
                                described_class.new('INFO'),
                                described_class.new('CVHTCall')))).length).to eq(14)
    end

    it 'should return an array containing the correct number of lines' do
      expect(subject.search('TestLogs/test.txt', described_class.new('uTILITIES',:insensitive)).length).to eq(11)
    end

    it 'should return an array containing the correct number of lines' do
      expect(subject.search('TestLogs/test.txt', described_class.new('New Call|Interaction Created',:insensitive)).length).to eq(2)
    end
  end
end

describe Keyword do

  subject { LogSearch.new }

  it_behaves_like :search_engine
end

describe KeywordPartDeux do

  subject { LogSearch.new }

  it_behaves_like :search_engine
end
