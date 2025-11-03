Feature: Add ratings to a store
    To better recommend stores, I want to be able to rate them

Scenario: Store has no ratings
    Given a new store
    When I check the store's ratings
    Then I should see a rating of "0.0"

Scenario: Add a rating to the store
    Given a new store
    When I check the store's ratings
    And I rate them "5"
    And I check the store's ratings
    Then I should see a rating of "5.0"

Scenario: Add another rating to the store
    Given a new store
    When someone else rates them "5"
    And I check the store's ratings
    And I rate them "3"
    And I reload the page
    Then I should see a rating of "4.0"

Scenario: Edit my rating
    Given a new store
    When I check the store's ratings
    And I rate them "5"
    And I rate them "3"
    And I reload the page
    Then I should see a rating of "3.0"