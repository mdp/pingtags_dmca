Feature: View a LinkedIn profile
  In order to view a profile PingTags
  I should be able to scan a code
  And see the profile
  
  Scenario: I try to view a profile
    Given a user exists
    When I visit a shortened URL
    Then I should see a profile
  