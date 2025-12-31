Feature: DateTimeZone Offset Adjustment during DST Overlap

  Scenario: Adjusting offset during DST end overlap in America/Sao_Paulo
    Given the time zone is "America/Sao_Paulo"
    And a DST overlap occurs at midnight on 2012-02-26 where clocks move back from 00:00 to 23:00
    And a date-time "2012-02-25T23:15:00.000-02:00" represents the first occurrence (DST)
    And a date-time "2012-02-25T23:15:00.000-03:00" represents the second occurrence (Standard)
    
    When I adjust the DST date-time to the earlier offset at overlap
    Then the result should be the DST date-time "2012-02-25T23:15:00.000-02:00"
    
    When I adjust the DST date-time to the later offset at overlap
    Then the result should be the Standard date-time "2012-02-25T23:15:00.000-03:00"
    
    When I adjust the Standard date-time to the earlier offset at overlap
    Then the result should be the DST date-time "2012-02-25T23:15:00.000-02:00"
    
    When I adjust the Standard date-time to the later offset at overlap
    Then the result should be the Standard date-time "2012-02-25T23:15:00.000-03:00"
