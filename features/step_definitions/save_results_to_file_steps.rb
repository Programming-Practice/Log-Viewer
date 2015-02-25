require '../../lib/save_results_to_file'


When(/^a user saves results to a file$/) do
  @ResultSaver = ResultSaver.new
  ResultSaver.execute()
end

Then(/^a file should be created$/) do
  File.exist?("results")
end