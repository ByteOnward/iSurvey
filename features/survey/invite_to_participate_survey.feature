Feature: Invite to Participate Survey

  In order to invite users to participate survey
  As a survey owner or admin
  I want to send out notification email with link 

Scenario: Send notification email to invite users to participate survey
  Given there are the following users:
    | email               | password |
    | example@example.com | password |
  And the role of "example@example.com" is "EWS"
  When the following survey is created:
    | name     | desc                                           | group|
    | Skillset | What status of the current employee skill sets | EWS  |
  Then there should have a invite email been sent to "example@example.com"