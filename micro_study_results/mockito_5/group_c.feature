Feature: Pure Mockito independence from JUnit

  As a developer using Mockito in an environment without JUnit
  I want pure Mockito classes to have no hard dependency on JUnit
  So that Mockito can be used in pure Java or TestNG environments

  Scenario: Pure Mockito classes should not depend on JUnit
    Given a class loader that excludes JUnit dependencies
    When pure Mockito classes are loaded, including "org.mockito.internal.verification.VerificationOverTimeImpl"
    Then all pure Mockito classes should load successfully without any dependency on JUnit
