Feature: Sign out

In order to protect my account from unauthorized access
As a signed user
I want to be able to sign out

@javascript
Scenario: User signs out
Given there are the following users:
  | username | email               | password |
  | example  | example@example.com | password |
And  I am signed in as "example@example.com" 
When I click "Sign out"
Then I should on the "homepage"
And  I should see "You need to sign in or sign up before continuing."

