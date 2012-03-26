Feature: Destroy Survey

In order to destroy the existing survey
As a survey owner or admin
I want to destroy my own survey easily

Scenario: destroy existing survey
Given there are the following users:
| email               | password |
| admin@example.com   | password |
And the role of "admin@example.com" is "Admin"
And I am signed in as "admin@example.com"
Given there is a survey called "Skillset"
And I am on "homepage"
When I follow "Destroy"
Then I should on the "SurveyView page"
And I should not see "Skillset"
