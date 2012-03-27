Feature: Edit User Permission

  In order to edit users' permission
  As a admin
  I want to edit users' permission easily

  @javascript
  Scenario: edit users' permission
    Given there are the following users:
      | email               | password |
      | admin@example.com   | password |
      | example@example.com | password |
    And the role of "admin@example.com" is "Admin"
    And I am signed in as "admin@example.com"
    When I visit ManageUsers page
    Then I should see "admin@example.com"
    And I should see "example@example.com"
    And there is role of "Owner"
    When I grant "Owner" to "example@example.com"
    Then the role of "example@example.com" should be "Owner"

