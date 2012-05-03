Feature: Create a new survey from existed one

  In order to create a new similar survey
  As a survey owner or admin
  I want to create a new survey from a existed one

  @javascript
  Scenario:  create a new survey from existed one successfully
    Given there are the following users:
      | username | email               | password |
      | admin    | admin@example.com   | password |
    And the role of "admin@example.com" is "Admin"
    And I am signed in as "admin@example.com"
    Given there is a survey called "Skillset"
    And I am on "homepage"
    And I follow "New"
    And I fill in "Name" with "CopiedSurvey"
    And I click "Submit"
    Then I should see "Survey was successfully created."
    And I should be on the project page for "CopiedSurvey"
    And I should see "CopiedSurvey"
    And I should see "What status of the current employee skill sets"
    And I should see "TestQuestion"
    And I should see "TestChoice"
    When I am on "homepage"
    And I should see "Skillset"
    And I should see "CopiedSurvey"
    And I should have 2 survey
