Feature: View Result

  In order to view the result of a survey
  As a survey owner or admin
  I want to view the result of a survey easily

  @javascript
  Scenario: view result
    Given there are the following users:
      | username | email               | password |
      | admin    | admin@example.com   | password |
    And the role of "admin@example.com" is "Admin"
    And I am signed in as "admin@example.com"
    Given there is a survey called "Skillset"
    And I am on "homepage"
    And I follow "Skillset"
    And I follow "Statistics"
    Then I should be on the result page for "Skillset"