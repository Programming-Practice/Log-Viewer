require 'spec_helper'

describe LineMatch do

  let(:subject) { LineMatch.new(4,'This should be returned') }

  it 'should return the line' do
    expect(subject.line).to eq('This should be returned')
  end

  it 'should return the line number' do
    expect(subject.line_num).to eq(4)
  end

  it 'should return a string of line number and the line' do
    expect(subject.to_s).to eq('4 This should be returned')
  end

  it 'should convert to a string automatically' do
    expect("#{subject}").to eq('4 This should be returned')
  end

end
