Feature: Submit email for reminder

  In order to be reminded of upcoming shoe releases
  As a user of the Shoe Store
  I want to be able to submit my email address

  Scenario Outline: Ability to submit email reminders
    Given I am on the shoe store site
    When I add an "<email>" reminder
    Then I will see a success notification with my "<email>" displayed

    Examples:
      | email              |
      | test@example.org   |
    # can add lots more examples if wish