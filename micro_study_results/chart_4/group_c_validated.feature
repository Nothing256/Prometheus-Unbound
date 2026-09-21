Feature: Axis data range calculation in XYPlot with null renderer

  Scenario: Calculate data range for domain axis when renderer is null
    Given an XYPlot with a dataset mapped to a domain axis
    And the renderer for the dataset is null
    When the data range for the domain axis is requested
    Then the data range should be calculated from the dataset domain values
    And no exception should be thrown

  Scenario: Calculate data range for range axis when renderer is null
    Given an XYPlot with a dataset mapped to a range axis
    And the renderer for the dataset is null
    When the data range for the range axis is requested
    Then the data range should be calculated from the dataset range values
    And no exception should be thrown

  Scenario: Set the renderer of an XYPlot to null
    Given an XYPlot configured with a dataset and an existing renderer
    When the renderer for the plot is set to null
    Then the renderer should be updated without throwing an exception
    And the plot should reconfigure its axes using the dataset values
