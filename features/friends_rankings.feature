Feature: Know which friends have the most points within a certain timeframe

Scenario: I'm rank 1 among friends
    Given 2 friends with points
    And that I'm logged in
    And that I have 3*five points "today"
    When I check my friends rankings
    Then I should see that I'm number 1 among 3

Scenario: Rank changes with timeframe
    Given 2 friends with points
    And that I'm logged in
    And that I have 3*five points "yesterday"
    When I check my friends rankings
    And I select "Today"
    Then I should see that I'm not there among 2 friends