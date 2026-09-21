Feature: Constant folding for addition expressions that may produce strings

  As a JavaScript developer using the Closure Compiler
  I want additions involving expressions that may evaluate to strings not to be folded as numeric additions
  So that string concatenation semantics are preserved at runtime

  Scenario: Do not fold additions when an operand is a conditional expression that may produce a string
    Given the JavaScript code:
      """
      var a =(Math.random()>0.5? '1' : 2 ) + 3 + 4;
      """
    When the code undergoes constant folding optimizations
    Then the resulting code should remain unchanged:
      """
      var a =(Math.random()>0.5? '1' : 2 ) + 3 + 4;
      """

  Scenario: Do not fold additions when an operand is a logical expression that may produce a string
    Given the JavaScript code:
      """
      var a = ((Math.random() ? 0 : 1) || (Math.random()>0.5? '1' : 2 )) + 3 + 4;
      """
    When the code undergoes constant folding optimizations
    Then the resulting code should remain unchanged:
      """
      var a = ((Math.random() ? 0 : 1) || (Math.random()>0.5? '1' : 2 )) + 3 + 4;
      """
