Feature: Locale Availability Check

  As a developer using Commons Lang
  I want to check if a specific Locale is in the list of available Locales
  So that I can validate Locale inputs safely and robustly

  Scenario: Check availability of a locale when the set is not yet initialized
    Given the set of available locales has not been explicitly initialized
    When I check if the default locale is available using "LocaleUtils.isAvailableLocale"
    Then the result should be true
    And the operation should not throw a NullPointerException

  Scenario: Check availability of a known available locale
    Given the available locales are initialized
    When I check if "en_US" is available
    Then the result should be true

  Scenario: Check availability of an unknown locale
    Given the available locales are initialized
    When I check if "xx_XX" is available
    Then the result should be false
