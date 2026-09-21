Feature: Missing return statement check in functions with try-finally

  Scenario: Function with return statement inside try block and following finally block
    Given JavaScript code with a function expected to return a value:
      """javascript
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
    When the compiler checks for missing return statements
    Then no missing return statement warning is reported
