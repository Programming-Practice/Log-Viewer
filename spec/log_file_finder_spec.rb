require_relative 'spec_helper'

describe LogFileFinder do

  DIRECTORY_WITHOUT_LOGS = 'TestLogs/empty_folder'
  DIRECTORY_WITH_MANY_LOGS = 'TestLogs/VHLogs/Logs'
  DIRECTORY_WITH_FIVE_LOGS = 'TestLogs/five_logs'
  NON_EXISTENT_DIRECTORY = 'does_not_exist'

  it 'should return an empty list there are no logs' do
    finder = LogFileFinder.new(DIRECTORY_WITHOUT_LOGS)
    expect(finder.main_output).to eq([])
  end

  it 'should return a list of five log files when pointed at the five_logs folder' do
    expect( LogFileFinder.new(DIRECTORY_WITH_FIVE_LOGS).get_main_output_count).to eq(5)
  end

  it 'should raise an error if directory name does not exist' do
    expect{ LogFileFinder.new(NON_EXISTENT_DIRECTORY) }.to raise_error IOError
  end

  it 'should raise an IOError if the directory name does not exist' do
    expect { LogFileFinder.new(NON_EXISTENT_DIRECTORY) }.to raise_error IOError
  end

  it 'should include the requested directory name when raising the error' do
    expect { LogFileFinder.new(NON_EXISTENT_DIRECTORY)}.to raise_error 'The directory "does_not_exist" does not exist.'
  end

  it 'should not return any files that do not have "MainOuputLog" in their filename' do
    LogFileFinder.new(DIRECTORY_WITH_MANY_LOGS).main_output.each do |file|
      expect(file).to match(/MainOutputLog_/)
    end
  end
  it 'should return all matches for all files in a directory' do
    LogFileFinder.new(DIRECTORY_WITH_FIVE_LOGS).main_output.each do |file|
        expect(LogSearch.new().search(file, ['Log file'], nil).length).to eq(1)
    end
  end
end

