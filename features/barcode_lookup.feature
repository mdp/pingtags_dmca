Feature: View a users profile from scanning a barcode
  In order to see a users mobile profile
  I should be able to visit their mobile page with my phone
  
  Scenario: Display a users public page on an iphone
    Given I scan a persons barcode with an iPhone
    Then I should see that persons iPhone formatted profile
  
  Scenario: Display a users public page on an iphone
    Given I scan a persons barcode with an G1
    Then I should see that persons G1 formatted profile
