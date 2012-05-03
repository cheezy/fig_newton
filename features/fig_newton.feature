Feature: Functionality of the fig_newton gem

  Scenario: Getting basic configuration data from a yml config file
    Given I have read the configuration file
    When I ask for the value for "base_url"
    Then I should see "http://cheezyworld.com"

  Scenario: Requesting data that does not exist should result in error
    Given I have read the configuration file
    When I ask for a value that does not exist named "does_not_exist"
    Then I should raise a NoMethodError exception
    
