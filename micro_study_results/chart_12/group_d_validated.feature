Feature: MultiplePiePlot Dataset Listener Registration

  Scenario: MultiplePiePlot registers as a change listener upon construction with a dataset
    Given a category dataset
    When a MultiplePiePlot is created with the category dataset
    Then the category dataset should have the MultiplePiePlot registered as a change listener
