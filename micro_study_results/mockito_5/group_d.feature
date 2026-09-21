Feature: Pure Mockito independence from JUnit

  Scenario: Loading VerificationOverTimeImpl without JUnit on the classpath
    Given JUnit is not present on the classpath
    When the class "org.mockito.internal.verification.VerificationOverTimeImpl" is loaded
    Then the class should load successfully without any dependency error
