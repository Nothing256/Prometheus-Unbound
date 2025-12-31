Feature: HTML Entity Unescaping Rules

  As a library user
  I want the unescape function to correctly handle named entities with missing semicolons
  So that I don't get incorrect characters for partial matches that happen to be valid entity names

  Scenario: Unescaping a string with mixed entity formats
    Given the input string:
      """
      Hello &amp;&LT&gt; &reg &angst; &angst &#960; &#960 &#x65B0; there &! &frac34; &copy; &COPY;
      """
    When the string is unescaped
    Then the result should be:
      """
      Hello &<> ® Å &angst π π 新 there &! ¾ © ©
      """
    And the entity "&angst" without a semicolon should remain as text "&angst"
    And the entity "&reg" without a semicolon should be unescaped to "®"
    And the numeric entity "&#960" without a semicolon should be unescaped to "π"
