Feature: Correctly calculate the index of the time period with the maximum middle value

  Scenario: The maximum middle index is not updated when a new period has a middle value larger than the minimum but smaller than the maximum
    Given a "TimePeriodValues" series named "Test"
    And I add a period from 100 to 200 with value 1.0
    And I add a period from 300 to 400 with value 2.0
    And I add a period from 0 to 50 with value 3.0
    When I add a period from 150 to 200 with value 4.0
    Then the index of the maximum middle value should be 1
