Feature: Elitism Rate Validation in ElitisticListPopulation

  Scenario: Reject negative elitism rate during construction with chromosome list
    Given a list of chromosomes is provided
    And a population limit of 100 is set
    When I attempt to create a new ElitisticListPopulation with an elitism rate of -0.25
    Then an OutOfRangeException should be thrown
