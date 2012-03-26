Feature: Create Survey

In order to create a new survey
As a survey owner or admin
I want to create a new survey easily

Background:
Given there are the following users:
| email               | password |
| admin@example.com   | password |
And the role of "admin@example.com" is "Admin"
And I am signed in as "admin@example.com"
Given I am on "the homepage"
When I follow "New Survey"

Scenario: Creating a survey
And I fill in "Name:" with "SkillSet"
And I fill in "Description:" with "What status of the current employee skill sets"
And I fill in "Question" with "TestQuestion"
And I select "Single Choice" from "Question Type:"
And I fill in "Choice" with "TestAnswer"
And I press "Submit"
Then I should see "Survey was successfully created."
And I should be on the project page for "SkillSet"
And I should see "SkillSet"
And I should see "What status of the current employee skill sets"
And I should see "TestQuestion"
And I should see "TestAnswer"
And I should have 1 survey

Scenario: Creating a survey without a name
And I fill in "Description:" with "What status of the current employee skill sets"
And I fill in "Question" with "TestQuestion"
And I select "Single Choice" from "Question Type:"
And I fill in "Choice" with "TestAnswer"
And I press "Submit"
Then I should see "Name can't be blank"
And I should on the "SurveyCreation page"
