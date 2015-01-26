require 'rspec'
require_relative '../lib/logSearch'


describe 'Log search should return correct search results' do

  it 'After searching test.txt, it should return an array containing the correct number of lines' do
    log = LogSearch.new
    expect(log.search('spec/test.txt' , 'Utilities').length).to eq(11)
  end
end