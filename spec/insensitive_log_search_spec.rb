require 'spec_helper'

describe InsensitiveLogSearch do

  describe '#search' do

    it 'should return an array containing the correct number of lines' do
      expect(subject.search('TestLogs/test.txt', ['uTILITIES'], nil).length).to eq(11)
    end

  end
end