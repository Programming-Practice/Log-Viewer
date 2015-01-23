Feature: Log File Finder
  The LogFileFinder points to the top of a directory tree full of log files. It supports methods to return the list of relative paths of various types of log files located within the tree.
  
  Scenario: Log File Finder should discover all the main output logs in the test folder
    Given I create a LogFileFinder pointed at the "TestLogs/VHLogs" folder
    When I ask for the main_output logs
    Then I should find 5 log files
