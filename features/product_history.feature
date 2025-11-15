Feature: Save past drinks and brands I've consumed
    To better know what my friends and I have consumed in the past, I'd like to be able to see a history of my past drinks

Scenario: There are no drinks in history
    Given that I'm logged in
    When I check my drink history
    Then I should see that there are 0 drinks

Scenario: There are some drinks in my history
    Given that I'm logged in
    When I add 2 drinks to my drink history
    And I check my drink history
    Then I should see that there are 2 drinks

Scenario: I delete an item from my history
    Given that I'm logged in
    When I add 1 drink to my drink history
    And I remove a drink from my drink history
    And I check my drink history
    Then I should see that there are 0 drinks