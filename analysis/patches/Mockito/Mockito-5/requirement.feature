Feature: VerificationOverTimeImpl should not strictly depend on JUnit

  To ensure Mockito can be used in environments without JUnit (e.g., TestNG, pure Java apps),
  internal classes must not have hard references to JUnit classes in their signatures or catch blocks
  that prevent class loading when JUnit is absent.

  Scenario: Loading VerificationOverTimeImpl without JUnit on classpath
    Given a class loader that explicitly excludes "junit" and "org.junit" packages
    When I load the class "org.mockito.internal.verification.VerificationOverTimeImpl"
    Then the class should load successfully
    And no "java.lang.NoClassDefFoundError" should be thrown

  Scenario: Retrying verification on assertion errors
    Given a verification mode wrapped in VerificationOverTimeImpl with a timeout
    And the delegate verification throws an "org.mockito.exceptions.verification.junit.ArgumentsAreDifferent"
    When verify is called
    Then the exception should be caught
    And the verification should be retried until the timeout expires
