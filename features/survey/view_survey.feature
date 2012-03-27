Feature: View Survey

  In order to add questions to a survey
  As a user
  I want to be able to see a list of available surveys

  Background:
    Given there are the following users:
      | email               | password |
      | example@example.com | password |
    And the role of "example@example.com" is "EWS"
    And I am signed in as "example@example.com"
    And there is a survey called "Skillset"
    And the group of "Skillset" is "EWS"
    And there is a survey called "Go for fun"
    And the group of "Go for fun" is "EWE"

  @javascript
  Scenario: Viewing visible surveys
    And I am on "homepage"
    And I should see "Skillset"
    And I should not see "Go for fun"
    When I follow "Skillset"
    Then I should be on the project page for "Skillset"

