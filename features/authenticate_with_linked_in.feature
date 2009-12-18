Feature: Authenticate with LinkedIn
  In order to link my profile to a Pingtag
  I should be able to login with LinkedIn
  
  Scenario: New user tries to login
    When I go to the login page
    Then I should see "LinkedIn"
  
  Scenario: When they login
    Given I am on the login page
    When I choose to authenticate with LinkedIn
    Then I should be redirected to "linkedin.com"
    
  Scenario: When I authorize PingTag
    Given I authorize PingTags
    When I return to PingTags
    Then I should see "Thanks"
    And I should see "Logged in as Mark Percival"
