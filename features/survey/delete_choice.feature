Feature: Delete Choice

  In order to delete choices to a survey
  As a survey owner or admin
  I want to delete choices to my own survey

  @javascript
  Scenario: delete choices
    Given there are the following users:
      | email               | password |
      | admin@example.com   | password |
    And the role of "admin@example.com" is "Admin"
    And I am signed in as "admin@example.com"
    Given there is a survey called "Skillset"
    And I am on "homepage"
    And I follow "Edit"
    When I click X to delete "TestChoice"
    And I click "Submit"
    Then I should see "TestQuestion"
    And I should not see "TestChoice"
