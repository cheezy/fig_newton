Feature: Functionality of the fig_newton gem

  Scenario: Getting basic configuration data from a yml config file
    Given I have read the configuration file
    When I ask for the value for "base_url"
    Then I should see "http://cheezyworld.com"

  Scenario: Requesting data that does not exist should result in error
    Given I have read the configuration file
    When I ask for a value that does not exist named "does_not_exist"
    Then I should raise a NoMethodError exception
    
  Scenario: Getting the default filename from an environment variable
    Given I have an environment variable named "FIG_NEWTON_FILE" set to "sample.yml"
    When I ask for the value for "from_the_env_file"
    Then I should see "read from the env file"
    
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

  Scenario: Using default directory and file
    Given I have read the default file from the default directory
    When I ask for the value for "base_url"
    Then I should see "http://cheezyworld.com"
    
  Scenario:  Requesting a numerical value
    Given I have read the configuration file
    When I ask for the value for "port"
    Then I should see 1234
