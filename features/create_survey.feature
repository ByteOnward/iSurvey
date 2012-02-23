Feature: create a new survey

In order to create a new survey
As a survey creator
I want to create a new survey easily

Background:
Given there are the following users:
| email             | password |
| admin@example.com | password |
And I am signed in as "admin@example.com" with password "password"
And I am on "the homepage"
When I follow "New Survey"

Scenario: Creating a survey
When I fill in "Name:" with "SkillSet"
And I fill in "Description:" with "What status of the current employee skill sets"
And I fill in "Question" with "TestQuestion"
And I fill in "Choice" with "TestChoice"
And I press "Submit"
Then I should see "Survey was successfully created."
And I should see "SkillSet"
And I should see "What status of the current employee skill sets"
And I should see "TestQuestion"
And I should see "TestChoice"
And I should have 1 survey

Scenario: Creating a survey without a name
When I fill in "Description" with "What status of the current employee skill sets"
And I fill in "Question" with "TestQuestion"
And I fill in "Choice" with "TestChoice"
And I press "Submit"
Then I should see "Name can't be blank"
And I should on "SurveyCreation page"

