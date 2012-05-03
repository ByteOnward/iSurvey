Feature: View Users

  In order to view registered users
  As a admin
  I want to be able to see a list of users

  @javascript
  Scenario: view users
    Given there are the following users:
    | username | email               | password |
    | admin    | admin@example.com   | password |
    | example  | example@example.com | password |
    And the role of "admin@example.com" is "Admin"
    And I am signed in as "admin@example.com"
    When I visit ManageUsers page
    Then I should see "admin@example.com"
    And I should see "example@example.com"



