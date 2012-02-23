Feature: update survey

In order to update survey information
As a survey owner
I want to update my own survey

Background:
Given there are the following users:
| email             | password |
| admin@example.com | password |
And I am signed in as "admin@example.com" with password "password"
And there are the following surveys:
| name       | desc         |
| Skillset   | SkillsetDesc |
And I am on "the homepage"
When I follow "Skillset"
And I follow "Edit"

Scenario: Updating a survey
And I fill in "Name" with "Skillset2"
And I press "Submit"
Then I should see "Survey was successfully updated."
And I should see "Skillset2"

Scenario: Updating a survey with invalid attributes is blink
And I fill in "Name" with ""
And I press "Submit"
Then I should see "Name can't be blank"


