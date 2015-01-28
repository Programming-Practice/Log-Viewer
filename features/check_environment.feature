Feature: All necessary registries and log files exist in our environment
  As a Support Representative or integrator
  I want to view only the data I need from the Virtual Hold log files

  @manual
  Scenario: The registry value that contains the main log files' path exists
    Given I have installed Virtual Hold
    Then the key 'MainLogFilePath' exists in the registry

  @manual
  Scenario: The path from the registry contains a Main directory
    Given I have obtained a log file path from the registry
    Then a folder with the name 'Main' exists in the log directory

  @manual
  Scenario: Main Output Files exists in the log directory
    Given a folder named 'Main' exists in the log directory
    Then Main output files can be found under the date directories
