Feature: Hypergeometric Distribution Sampling
  The Hypergeometric distribution should correctly sample values within the valid support range
  even with extreme parameter values to ensure the outputs are mathematically sound

  Scenario: Sample within support bounds for extreme parameters
    Given a Hypergeometric distribution with populationSize=43130568, numberOfSuccesses=42976365, and sampleSize=50
    When I sample 100 values from the distribution
    Then all sampled values should be greater than or equal to 0
    And all sampled values should be less than or equal to 50

  Scenario: Sample within theoretical support bounds
    Given a Hypergeometric distribution with any valid parameters populationSize=N, numberOfSuccesses=m, and sampleSize=n
    When I sample a value from the distribution
    Then the sampled value should be greater than or equal to max(0, n + m - N)
    And the sampled value should be less than or equal to min(m, n)

  Scenario: Proper handling of large parameter values
    Given a Hypergeometric distribution with large parameter values where populationSize=43130568, numberOfSuccesses=42976365, and sampleSize=50
    When I compute cumulative probabilities
    Then the calculations should handle floating-point precision appropriately without returning NaN or incorrect values