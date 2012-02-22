Feature: view survey

In order to add questions to a survey
As a user
I want to be able to see a list of available surveys

Background:
Given there are the following users:
| email            | password |
| user@example.com | password |
And I am signed in as "user@example.com" with password "password"

And there are the following surveys:
| name       | desc         |
| Skillset   | SkillsetDesc |
| Go for fun | GoForFunDesc |

#And "user@example.com" can view the "Skillset" project

Scenario: Listing all Skillsets
And I am on "the homepage"
And I should see "Skillset"
And I should see "Go for fun"
When I follow "Skillset"
Then I should see "SkillsetDesc"

