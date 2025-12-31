Feature: Robust Sampling in DiscreteDistribution

  Scenario: Sampling from a distribution with heterogeneous component types
    Given a list of samples containing two different anonymous Objects
    And the first object has a probability of 0.0
    And the second object has a probability of 1.0
    When a DiscreteDistribution is created with these samples
    And I request a sample of size 1
    Then the operation should successfully return an array of length 1
    And the operation should not throw an ArrayStoreException
