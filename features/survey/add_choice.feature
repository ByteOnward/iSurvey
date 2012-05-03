Feature: Add Choice

  In order to add choices to a question
  As a survey creator
  I want to add choices easily

  @javascript
  Scenario: add choices
    Given there are the following users:
      | username | email               | password |
      | admin    | admin@example.com   | password |
    And the role of "admin@example.com" is "Admin"
    And I am signed in as "admin@example.com"
    Given there is a survey called "Skillset"
    And I am on "homepage"
    When I follow "Edit"
    When I press "Add Choice"
    And I fill in new choice with "TestNewChoice"
    And I click "Submit"
    Then I should see "TestChoice"
    And I should see "TestNewChoice"

