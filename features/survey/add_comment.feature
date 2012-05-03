Feature: Add Comment

  In order to add comments to a survey
  As a user
  I want to add comments to a survey easily

  Scenario: add comments
    Given there are the following users:
      | username | email               | password |
      | example  | example@example.com | password |
    And the role of "example@example.com" is "EWS"
    And I am signed in as "example@example.com"
    And there is a survey called "Skillset"
    And the group of "Skillset" is "EWS"
    And I am on "homepage"
    And I follow "Skillset"
    And I choose "TestChoice"
    And I press "Submit"
    And I fill in "Your Comment" with "TestComment"
    When I press "Add Comment"
    #Then I should see "TestComment"