Feature: Pearson's Correlation P-Value Calculation

  Background:
    Given I have a PearsonsCorrelation instance

  Scenario: P-value should not be zero for strong correlations within double precision
    Given a dataset with 120 pairs of (x, y) values
    And the data exhibits a very strong positive correlation where y is slightly perturbed from x
    When I compute the p-value matrix for the correlation
    Then the p-value for the correlation between x and y should be strictly greater than 0.0
