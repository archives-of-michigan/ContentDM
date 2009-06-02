Feature: Accessing collections
  As a gem user
  I want to request a list collections from a ContentDM server via JSON
  So that I can have a list of collection models
  
  Scenario: Requesting all collections sans cache
    When I request all collections
    Then I should have the full list of collections