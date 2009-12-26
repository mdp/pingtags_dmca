Feature: Track barcode scans
  In order to see who scans my barcode
  I should be see a list of scans

  Scenario: An iPhone scans my barcode
    When someones iphone scans my barcode
    Then I should see that persons scan listed