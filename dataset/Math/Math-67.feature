Feature: Robust handling of failed optimization runs in MultiStartUnivariateRealOptimizer

  Background:
    Given a MultiStartUnivariateRealOptimizer initialized with a specific number of starts
    And an underlying optimizer that may fail (return NaN or throw exception) for some starts

  Scenario: Optimization runs correctly filter out failed attempts without crashing
    Given the optimizer is configured with 5 starts
    And the underlying optimizer is mocked to fail (throw exception) on the first start
    And the underlying optimizer succeeds on the remaining 4 starts
    When I call the optimize method
    Then the process should complete without throwing an ArrayIndexOutOfBoundsException
    And the getOptima method should return an array where the valid optima are sorted by their function values
    And the getOptimaValues method should return the corresponding function values for the sorted optima
    And the result of the optimize method should match the best valid optimum found
    And the getResult method should return the best valid optimum found
    And the getFunctionValue method should return the function value of the best valid optimum

  Scenario: Optima and OptimaValues arrays remain synchronized after filtering NaNs
    Given the optimizer is configured with multiple starts
    And some starts fail resulting in NaN values
    When I retrieve the optima and optimaValues arrays
    Then the value at index i in optimaValues should be the function evaluation of the point at index i in optima for all valid i
    And the NaN values should be placed at the end of the arrays
