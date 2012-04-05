Feature: Invite to Participate Survey

  In order to invite users to participate survey
  As a survey owner or admin
  I want to send out notification email with link

  @javascript
  Scenario: Send notification email to invite users to participate survey
    Given there are the following users:
      | email               | password |
      | admin@example.com   | password |
      | example@example.com | password |
    And the role of "admin@example.com" is "Admin"
    And the role of "example@example.com" is "EWS"
    And I am signed in as "admin@example.com"
    Given I am on "the homepage"
    When I click New Survey button
    And I fill in "Name:" with "SkillSet"
    And I fill in "Description:" with "What status of the current employee skill sets"
    And I select "EWS" from "Group:"
    And I fill in "Question" with "TestQuestion"
    And I select "Single Choice" from "Question Type:"
    And I fill in "Choice" with "TestAnswer"
    And I click "Submit"
    Then there should have a invite email been sent to "example@example.com"