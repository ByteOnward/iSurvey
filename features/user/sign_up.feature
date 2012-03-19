Feature: User Sign Up

In order to view survey dashboard
As a new user
I want to sign up a account

Scenario: unsuccessful sign up
Given I am not logged in
And I am on "signup page"
And I fill "Email" with "invalid@email"
And I fill "Password" with "password"
And I fill "Password confirmation" with "verify password"
And I press "Sign up"
Then I should see "Email is invalid"
And I should see "Password doesn't match confirmation"

Scenario: successful sign up
Given I am not logged in
And I am on "signup page"
And I fill "Email" with "example@example.com"
And I fill "Password" with "password"
And I fill "Password confirmation" with "password"
And I press "Sign up"
Then I should see "You need to sign in or sign up before continuing."
#And there should have a active email been sent to "example@example.com"

