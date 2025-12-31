Feature: Poisson Distribution Initialization

  Scenario: Create Poisson distribution with invalid mean
    Given a user wants to create a Poisson distribution
    When the user initializes the distribution with a mean of -1
    Then the system should throw a NotStrictlyPositiveException
    And the exception message should indicate that the mean must be positive
