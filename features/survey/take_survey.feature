Feature: Take Survey

  In order to take a survey
  As a user
  I want to be able to take a survey easily

  Background:
    Given there are the following users:
      | username | email               | password |
      | example  | example@example.com | password |
    And the role of "example@example.com" is "EWS"
    And I am signed in as "example@example.com"
    And there is a survey called "Skillset"
    And the group of "Skillset" is "EWS"

  @javascript
  Scenario: take survey successfully
    And I am on "homepage"
    And I follow "Skillset"
    And I choose "TestChoice"
    When I press "Submit"
    Then I should see "Thank you for your participation."

  @javascript
  Scenario: taken survey repeatly
    And I am on "homepage"
    And I follow "Skillset"
    And I choose "TestChoice"
    When I press "Submit"
    Then I should see "Thank you for your participation."
    And I am on "homepage"
    And I follow "Skillset"
    Then I should on the statistics page of "Skillset"