Feature: MultiplePiePlot Dataset Listener Registration

  Scenario: Initializing MultiplePiePlot with a dataset registers listener
    Given a category dataset
    When a MultiplePiePlot is created with the dataset
    Then the dataset should have the plot registered as a listener
    And the plot should have the dataset assigned

  Scenario: Initializing MultiplePiePlot with default constructor
    When a MultiplePiePlot is created with no arguments
    Then the plot should have no dataset assigned
