Feature: Continued Fraction Numerical Stability

  The Continued Fraction evaluation used by the Beta distribution (and others)
  must be robust against intermediate values underflowing to zero, which can
  incorrectly lead to NaN results during the recurrence calculation.

  Scenario: Prevent NaN divergence in Continued Fraction for large Binomial Distribution trials
    Given a BinomialDistribution with trials = 500000 and p = 0.5
    When I call inverseCumulativeProbability(0.5)
    Then the result should be 250000
    And the calculation should not diverge to NaN
