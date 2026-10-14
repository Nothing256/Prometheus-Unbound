Feature: LocaleUtils availableLocaleSet method
  The availableLocaleSet method should provide thread-safe access to a consistent,
  immutable set of all available locales on the system. Multiple calls to the method
  should return the same reference to ensure consistency and prevent race conditions.

  Scenario: Getting available locale set multiple times
    Given the system has a set of available locales
    When a user calls LocaleUtils.availableLocaleSet() multiple times
    Then all calls should return the exact same Set reference
    And the returned set should contain all locales from Locale.getAvailableLocales()
    And the returned set should be unmodifiable
    
  Scenario: Concurrent access to available locale set
    Given multiple threads accessing LocaleUtils.availableLocaleSet() simultaneously  
    When each thread calls LocaleUtils.availableLocaleSet()
    Then all threads should receive the same set reference once initialization is complete
    And no race conditions should occur during initialization
    And the returned set should contain all locales from Locale.getAvailableLocales()
    
  Scenario: Available locale set contains all system locales
    Given the system has a specific set of available locales
    When a user calls LocaleUtils.availableLocaleSet()
    Then the returned set should contain exactly the same locales as Locale.getAvailableLocales()
    And the set should be consistent across multiple calls
    And the set should be unmodifiable to prevent external modification