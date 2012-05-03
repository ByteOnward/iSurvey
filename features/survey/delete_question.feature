Feature: Delete Question

  In order to delete questions to a survey
  As a survey owner or admin
  I want to delete questions to my own survey

  @javascript
  Scenario: delete questions
    Given there are the following users:
      | username | email               | password |
      | admin    | admin@example.com   | password |
    And the role of "admin@example.com" is "Admin"
    And I am signed in as "admin@example.com"
    Given there is a survey called "Skillset"
    And I am on "homepage"
    And I follow "Edit"
    When I click X to delete "TestQuestion"
    And I click "Submit"
    Then I should not see "TestQuestion"
    And I should not see "TestChoice"
