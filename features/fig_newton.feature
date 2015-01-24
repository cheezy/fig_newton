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

  Scenario: Using a file that has the same name as the hostname
    Given I have a yml file that is named after the hostname
    When I ask for the value for "from_the_hostname_file"
    Then I should see "read from the hostname file"
    And I should remove the file

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
    And the "fifth" value for the node should be true
    And the "sixth" value for the node should be false

  Scenario: Using default directory and file
    Given I have read the default file from the default directory
    When I ask for the value for "base_url"
    Then I should see "http://cheezyworld.com"

  Scenario:  Requesting a numerical value
    Given I have read the configuration file
    When I ask for the value for "port"
    Then I should see 1234

  Scenario:  Requesting a boolean value
    Given I have read the configuration file
    When I ask for the value for "use_ssl"
    Then I should see false

  Scenario:  Requesting data from a node can be converted to a hash
    Given I have read the configuration file
    When I ask for the value for "database"
    Then I should have a node
    And the hash of values should look like:
      | username | steve  |
      | password | secret |

  Scenario: Requesting data that does not exist but has a default value should return the default value
    Given I have read the configuration file
    When I ask for a value that does not exist named "does_not_exist" that has a default value "the default value"
    Then I should see "the default value"

  Scenario: Requesting data that does not exist but has a default value of true should return the default value of true
    Given I have read the configuration file
    When I ask for a value that does not exist named "does_not_exist" that has a default value true
    Then I should see true

  Scenario: Requesting data that does not exist but has a default value of false should return the default value of false
    Given I have read the configuration file
    When I ask for a value that does not exist named "does_not_exist" that has a default value false
    Then I should see false

  Scenario: Requesting data that does not exist but has a default block should return the block result
    Given I have read the configuration file
    When I ask for a value that does not exist named "does_not_exist" that has a default block returning "the default value"
    Then I should see "the default value"

  Scenario: Requesting data that does not exist but has a default lambda should return the lambda result
    Given I have read the configuration file
    When I ask for a value that does not exist named "does_not_exist" that has a default lambda returning "the default value"
    Then I should see "the default value"
    And the lambda should be passed the property "does_not_exist"

  Scenario: Requesting data that does not exist but has a default proc should return the proc result
    Given I have read the configuration file
    When I ask for a value that does not exist named "does_not_exist" that has a default proc returning "the default value"
    Then I should see "the default value"
