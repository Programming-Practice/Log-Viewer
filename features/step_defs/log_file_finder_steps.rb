require 'log_file_finder'

Given(/^I create a LogFileFinder pointed at the "(.*?)" folder$/) do |dir_name|
  @finder = LogFileFinder.new(dir_name)
end

When(/^I ask for the main_output logs$/) do
  @main_output_logs = @finder.main_output
end

Then(/^I should find (\d+) log files$/) do |count_s|
  expect(@main_output_logs.length).to eq(count_s.to_i)
end

