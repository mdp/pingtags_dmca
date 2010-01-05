Feature: Track who views a users profile
  In order to see who views my pingtag
  I should see a list of clicks
  
  Scenario: Display a users public page on an iphone
    Given I scan a persons barcode with an iPhone
    Then I should see that persons iPhone formatted profile
