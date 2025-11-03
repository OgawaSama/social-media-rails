Feature: Search for the best wine places
    As a sommelier, I want to be able to find the best rated wine shops

Scenario: There are no wine shops
    Given that I'm logged in
    When I search for wine shops
    Then I should see that there are 0 wine shops

Scenario: There is one wine shop
    Given that I'm logged in
    And there are 1 wine shops
    When I search for wine shops
    Then I should see that there are 1 wine shops

Scenario: There are many wine shop
    Given that I'm logged in
    And there are 3 wine shops
    When I search for wine shops
    Then I should see that there are 3 wine shops
    And the first has the best rating