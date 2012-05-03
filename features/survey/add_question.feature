Feature: Add Question

  In order to add questions to a survey
  As a survey creator
  I want to add questions easily

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
    When I press "Add Question"
    And I fill in new question with "TestNewQuestion"
    And I fill in choice of "TestNewQuestion"with "TestNewChoice"
    And I click "Submit"
    Then I should see "TestChoice"
    And I should see "TestChoice"
    And I should see "TestNewQuestion"
    And I should see "TestNewChoice"

