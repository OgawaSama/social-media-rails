Feature: Rank users based on the points sum in consumed items
    To know which consumers consume the most and promote certain items over others, I want to be able to add points to my menu items and rank customers based on their comsumption


Scenario: Someone consumes an item worth 10 points
    Given a new store
    And that it has an item worth 10 points
    And that I'm logged in
    When I add that item as consumed
    And I check the rankings
    Then I should see myself with 10 points