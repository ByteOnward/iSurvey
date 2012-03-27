Feature: Find Password Back

In order to find forgot password back
As a user
I want to find my password back easily

Background:
Given there are the following users:
| email               | password |
| example@example.com | password |

And I am on "signin page"
When I follow "Forgot your password?"

@javascript
Scenario: find password back
When I fill in "Email" with "example@example.com"
And I press "Send me reset password instructions"
Then I should see "You will receive an email with instructions about how to reset your password in a few minutes."

@javascript
Scenario: find password with a nonexistent email
When I fill in "Email" with "nonexistentuser@example.com"
And I press "Send me reset password instructions"
Then I should see "Email not found"

