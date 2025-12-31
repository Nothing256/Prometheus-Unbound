Feature: Parse data-only tags
  Ensure that data-only tags (like script, textarea, title, etc.) are parsed correctly,
  specifically ensuring that text following the closing tag is placed after the element, not inside it.

  Scenario: Text appearing after a script tag
    Given the input HTML is "<html><body>pre <script>inner</script> aft</body></html>"
    When the document is parsed
    Then the output HTML should be "<html><head></head><body>pre <script>inner</script> aft</body></html>"
