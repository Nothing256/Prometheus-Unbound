Feature: BigMatrix Operation Logic

  Scenario: Operating on a vector with a non-square matrix where rows > columns
    Given a BigMatrix with 3 rows and 2 columns initialized with:
      | 1 | 2 |
      | 3 | 4 |
      | 5 | 6 |
    And a BigDecimal vector of length 2:
      | 1 |
      | 1 |
    When the matrix operates on the vector
    Then the result should be a vector of length 3
    And the result values should be:
      | 3.0  |
      | 7.0  |
      | 11.0 |
