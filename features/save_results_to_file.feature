Feature: Save Results To File
  Save Results To File receives input and creates a .CSV file within the working directory that includes received input.

  Scenario: A file is created with the name specified by user
    When a user saves results to a file
    Then a file should be created