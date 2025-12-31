Feature: Robustness of Normal Distribution Cumulative Probability

  Scenario Outline: Cumulative probability calculation handles extreme values gracefully
    Given a Normal Distribution with mean 0.0 and standard deviation 1.0
    When I calculate the cumulative probability for <value>
    Then the result should be <expected>
    And the calculation should not throw an exception

    Examples:
      | value | expected |
      | 40.0  | 1.0      |
      | -40.0 | 0.0      |
      | 100.0 | 1.0      |
      | -100.0| 0.0      |
      | 1.7976931348623157E308 | 1.0 |
      | -1.7976931348623157E308 | 0.0 |
