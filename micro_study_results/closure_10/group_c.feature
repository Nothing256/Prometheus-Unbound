Feature: Peephole constant folding of additions with potentially string operands

  Scenario: Do not fold addition with a conditional operand that may evaluate to a string
    Given JavaScript code "var a =(Math.random()>0.5? '1' : 2 ) + 3 + 4;"
    When peephole constant folding is applied
    Then the code should remain unchanged as "var a =(Math.random()>0.5? '1' : 2 ) + 3 + 4;"

  Scenario: Do not fold addition with a logical OR operand that may evaluate to a string
    Given JavaScript code "var a = ((Math.random() ? 0 : 1) || (Math.random()>0.5? '1' : 2 )) + 3 + 4;"
    When peephole constant folding is applied
    Then the code should remain unchanged as "var a = ((Math.random() ? 0 : 1) || (Math.random()>0.5? '1' : 2 )) + 3 + 4;"
