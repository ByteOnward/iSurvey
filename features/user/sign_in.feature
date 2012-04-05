Feature: Sign In

In order to use the site
As a user
I want to be able to sign in

#@javascript
#Scenario: Sign in via confirmation
#Given there are the following users:
#| email               | password | unconfirmed |
#| example@example.com | password | true        |
#And "example@example.com" opens the email with subject "Confirmation #instructions"
#And they click the first link in the email
#Then I should see "Your account was successfully confirmed"
#And I should see "Signed in as example@example.com"

@javascript
Scenario: Sign in via form
Given there are the following users:
| email               | password |
| example@example.com | password |
And I am on "homepage"
And I fill in "Email" with "example@example.com"
And I fill in "Password" with "password"
And I press "Sign in"
Then I should see "Signed in successfully."

#@javascript
#Scenario: Unconfirmed user sign in via form 
#Given there are the following users:
#| email               | password | unconfirmed |
#| example@example.com | password | true        |
#And I am on "homepage"
#And I fill in "Email" with "example@example.com"
#And I fill in "Password" with "password"
#And I press "Sign in"
#Then I should see "You have to confirm your account before continuing."
