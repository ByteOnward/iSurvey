Feature: Update Survey

In order to update survey information
As a survey owner or admin
I want to update my own survey

Background:
  Given there are the following users:
    | email               | password |
    | admin@example.com   | password |
  And the role of "admin@example.com" is "Admin"
  And I am signed in as "admin@example.com"
  Given there is a survey called "Skillset"
  And I am on "homepage"
  When I follow "Edit"

@javascript
Scenario: Updating a survey
And I fill in "Name" with "Skillset2"
And I click "Submit"
Then I should see "Survey was successfully updated."
And I should be on the project page for "Skillset2"

@javascript
Scenario: Updating a survey with invalid attributes is blink
And I fill in "Name" with empty
And I click "Submit"
Then I should see "Name can't be blank"
And I fill in "Name" with "Skillset2"
And I click "Submit"
Then I should see "Survey was successfully updated."
And I should be on the project page for "Skillset2"
