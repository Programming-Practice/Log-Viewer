require 'log_file_finder'

Given(/^I create a LogFileFinder pointed at the "(.*?)" folder$/) do |dir_name|
  begin
    @finder = LogFileFinder.new(dir_name)
  rescue Exception => exception
    @exception = exception
  end
end

When(/^I ask for the main_output logs$/) do
  @main_output_logs = @finder.main_output
end

Then(/^I should find (\d+) log files$/) do |count_s|
  expect(@main_output_logs.length).to eq(count_s.to_i)
end

Then(/^I should expect an exception$/) do
  expect(@exception).to_not be_nil
end

Then(/^I should expect an? (.*?) exception$/) do |exception_class|
  step "I should expect an exception"
  expect(@exception.class.name).to eq(exception_class)
end

Then(/^I should expect an? (.*?) exception with message "(.*?)"$/) do |exception_class,exception_message|
  step "I should expect a #{exception_class} exception"
  expect(@exception.to_s).to eq(exception_message)
end
