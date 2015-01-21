Feature: Log File Finder

Scenario: Log File Finder should discover all the main output logs in the test folder
  Given I create a LogFileFinder pointed at the "TestLogs/VHLogs" folder
  When I ask for the main_output logs
  Then I should find 19 log files
