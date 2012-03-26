Feature: Search User

  In order to search a specific user
  As a admin
  I want to search a user easily

  Scenario: search users
    Given there are the following users:
      | email               | password |
      | admin@example.com   | password |
      | example@example.com | password |
    And the role of "admin@example.com" is "Admin"
    And I am signed in as "admin@example.com"
    When I visit ManageUsers page
    Then I should see "admin@example.com"
    And I should see "example@example.com"
    When I fill in "Search Users:" with "admin@example.com"
    And I press "Search"
    Then I should see "admin@example.com"
    And I should not see "example@example.com"
