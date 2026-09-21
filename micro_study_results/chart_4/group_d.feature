Feature: XYPlot data range calculation with null renderer

  As a user of JFreeChart
  I want XYPlot to determine the data range of an axis when no renderer is assigned
  So that chart creation and axis range calculations succeed without throwing a NullPointerException

  Scenario: Calculate axis data range when XYPlot has a dataset and a null renderer
    Given an XYPlot containing an XYDataset with data points
    And the renderer for the dataset is null
    When the data range is requested for an axis mapped to the dataset
    Then the data range should be successfully determined from the dataset
    And no NullPointerException should be thrown

  Scenario: Auto-adjust axis range when creating a chart with an initial null renderer
    Given an XYDataset containing data points
    When a chart is constructed with the dataset and an initial null renderer
    Then the axis auto-range should be calculated without throwing a NullPointerException
