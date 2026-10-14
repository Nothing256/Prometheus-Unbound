Feature: Hypergeometric Distribution Correctness

  Scenario: Sampling from a Hypergeometric Distribution with large parameters
    Given a Hypergeometric Distribution with population size 43130568, number of successes 42976365, and sample size 50
    When I sample from the distribution
    Then the sample should be greater than or equal to 0
    And the sample should be less than or equal to 50
    And the numerical mean should be approximately 49.82

  Scenario: Calculating Numerical Mean with potential integer overflow
    Given a Hypergeometric Distribution with population size 43130568, number of successes 42976365, and sample size 50
    When I calculate the numerical mean
    Then the result should be positive
