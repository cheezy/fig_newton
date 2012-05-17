Feature: Functionality of the fig_newton gem

  Scenario: Getting basic configuration data from a yml config file
    Given I have read the configuration file
    When I ask for the value for "base_url"
    Then I should see "http://cheezyworld.com"

  Scenario: Requesting data that does not exist should result in error
    Given I have read the configuration file
    When I ask for a value that does not exist named "does_not_exist"
    Then I should raise a NoMethodError exception
    
  Scenario: Requesting data that contains a node of additional data
    Given I have read the configuration file
    When I ask for the value for "database"
    Then I should have a node
    And the "username" value for the node should be "steve"
    And the "password" value for the node should be "secret"

  Scenario: Requesting data from multiple nested data
    Given I have read the configuration file
    When I ask for the value for "first"
    And I ask for the node value for "second"
    Then the "third" value for the node should be "foo"
    And the "fourth" value for the node should be "bar"
