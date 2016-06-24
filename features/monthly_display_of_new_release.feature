Feature: Monthly display of new releases

  In order to view upcoming shoes being released every month
  As a user of the Shoe store
  I want to be able to visit a link for each month and see the shoes being released

  Scenario Outline: Check each month's shoes
    Given I am on the shoe store site
    When I check the month of "<month>"
    Then I should see a description and image and price for each shoe

    Examples:
    | month     |
    | January   |
    | February  |
    | March     |
    | April     |
    | May       |
    | June      |
    | July      |
    | August    |
    | September |
    | October   |
    | November  |
    | December  |