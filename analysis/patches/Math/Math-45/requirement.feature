Feature: OpenMapRealMatrix Constructor Validation

  Scenario: Reject matrix dimensions that exceed integer storage capacity
    When I attempt to instantiate a new OpenMapRealMatrix with 3 rows and 2147483647 columns
    Then the operation should fail by throwing a NumberIsTooLargeException
