require 'result_saver'


When(/^a user saves results to a file$/) do
  @ResultSaver = ResultSaver.new
  expect(@ResultSaver.execute()).to eq("unexpected value")
end

Then(/^a file should be created$/) do
  File.exist?("results")
end