require_relative "MainOutputLog"


describe "object exists" do
  it "returns an object" do
    mainLog = MainOutputLogFile.new
    mainLog.should_not == nil
  end
end
