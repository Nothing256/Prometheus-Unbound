Feature: BitsStreamGenerator Serialization

  In order to ensure reproducible random sequences across serialization boundaries
  As a developer using Commons Math
  I want the BitsStreamGenerator to correctly persist its internal state, specifically the cached Gaussian value

  Scenario: Serialization of GammaDistribution preserves RandomGenerator state
    Given a GammaDistribution with shape 4.0 and scale 2.0
    And the distribution is seeded with a fixed seed 123
    And I sample the distribution once to advance the RNG state
    When I clone the distribution via serialization
    Then the next sample from the original distribution should equal the next sample from the cloned distribution
