require 'spec_helper'

describe LineMatch do

  it 'should return the line' do
    line_num = 4
    line = 'This should be returned'
    results = LineMatch.new(line_num,line)
    expect(results.line).to eq('This should be returned')
  end

  it 'should return the line number' do
    line_num = 4
    line = 'This should be returned'
    results = LineMatch.new(line_num,line)
    expect(results.line_num).to eq(4)
  end

  it 'should return a string of line number and the line' do
    line_num = 4
    line = 'This should be returned'
    results = LineMatch.new(line_num,line)
    expect(results.to_s).to eq('4 This should be returned')
  end

end