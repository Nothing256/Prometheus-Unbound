Feature: X5455 Extended Timestamp Validation

  The X5455 Extended Timestamp extra field must strictly adhere to the Signed 32-bit Integer limit
  for its timestamps (modify, access, create), as per the Info-ZIP specification. This ensures
  compatibility and avoids incorrect unsigned interpretation in systems expecting signed values.

  Scenario: Reject timestamp exceeding Signed 32-bit Integer range
    Given I have a X5455_ExtendedTimestamp instance
    # 2^31 seconds past epoch (Jan 19, 2038 03:14:08 UTC + 1 second)
    # This is 1 second past the max signed 32-bit integer limit (2147483647)
    When I attempt to set the Modify Java Time to 2147483648 seconds past epoch
    Then the operation should fail with an IllegalArgumentException
    And the exception message should contain "X5455 timestamps must fit in a signed 32 bit integer"
