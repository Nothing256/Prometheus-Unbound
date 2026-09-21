Feature: Missing return statement check

  Scenario: Function with return in try block and return after finally block
    Given the JavaScript code:
      """
      /** @return {number} */
      function foo() {
        var a = f();
        try {
          alert();
          if (a > 0) return 1;
        } finally {
          a = 5;
        }
        return 2;
      }
      """
    When the compiler checks the code for missing return statements
    Then no missing return statement warning should be reported
