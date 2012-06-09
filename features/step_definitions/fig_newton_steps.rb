Given /^I have read the configuration file$/ do
  FigNewton.yml_directory = 'config/yaml'
  FigNewton.load 'test_config.yml'
end

When /^I have read the default file from the default directory$/ do
  FigNewton.yml = nil
end

When /^I ask for the value for "([^\"]*)"$/ do |key|
  @value = FigNewton.send key
end

Then /^I should see "([^\"]*)"$/ do |value|
  @value.should == value
end

When /^I ask for a value that does not exist named "([^\"]*)"$/ do |non_existing|
  @does_not_exist = non_existing
end

Then /^I should raise a NoMethodError exception$/ do
  expect{ FigNewton.send(@does_not_exist) }.to raise_error(NoMethodError) 
end

Then /^I should have a node$/ do
  @value.should be_an_instance_of FigNewton::Node
end

Then /^the "([^\"]*)" value for the node should be "([^\"]*)"$/ do |key, value|
  @value.send(key).should == value
end

When /^I ask for the node value for "([^\"]*)"$/ do |key|
  @value = @value.send(key)
end

Given /^I have an environment variable named "([^\"]*)" set to "([^\"]*)"$/ do |env_name, filename|
  ENV[env_name] = filename
  FigNewton.yml_directory = 'config/yaml'
  FigNewton.instance_variable_set(:@yml, nil)
end
