Given (/^I have read the configuration file$/) do
  FigNewton.yml_directory = 'config/yaml'
  FigNewton.load 'test_config.yml'
end

When (/^I have read the default file from the default directory$/) do
  FigNewton.yml = nil
end

When (/^I ask for the value for "([^\"]*)"$/) do |key|
  @value = FigNewton.send key
end

Then (/^I should see "([^\"]*)"$/) do |value|
  expect(@value).to eql value
end

Then (/^I should see (\d+)$/) do |value|
  expect(@value).to eql value.to_i
end

Then (/^I should see :([^\"]*)$/) do |value|
  expect(@value).to eql value.to_sym
end

Then (/^I should see true$/) do
  expect(@value).to be true
end

Then (/^I should see false$/) do
  expect(@value).to be false
end

When (/^I ask for a value that does not exist named "([^\"]*)"$/) do |non_existing|
  @does_not_exist = non_existing
end

Then (/^I should raise a NoMethodError exception$/) do
  expect{ FigNewton.send(@does_not_exist) }.to raise_error(NoMethodError) 
end

Then (/^I should have a node$/) do
  expect(@value).to be_an_instance_of FigNewton::Node
end

Then (/^the "([^\"]*)" value for the node should be "([^\"]*)"$/) do |key, value|
  expect(@value.send(key)).to eql value
end

When (/^I ask for the node value for "([^\"]*)"$/) do |key|
  @value = @value.send(key)
end

Given (/^I have an environment variable named "([^\"]*)" set to "([^\"]*)"$/) do |env_name, filename|
  FigNewton.yml = nil
  ENV[env_name] = filename
  FigNewton.yml_directory = 'config/yaml'  
  FigNewton.instance_variable_set(:@yml, nil)
end

Then (/^the hash of values should look like:$/) do |table|
  expect(table.transpose.hashes.first).to eql @value.to_hash
end

Given (/^I have a yml file that is named after the hostname$/) do
  FigNewton.yml = nil
  FigNewton.yml_directory = 'config/yaml'
  @hostname = Socket.gethostname
  File.open("config/yaml/#{@hostname}.yml", 'w') {|file| file.write("from_the_hostname_file:  read from the hostname file\n")}
end

Then (/^I should remove the file$/) do
  File.delete("config/yaml/#{@hostname}.yml")
end

When (/^I ask for a value that does not exist named "(.+)" that has a default value "(.+)"$/) do |key, value|
  @value = FigNewton.send key, value
end

When (/^I ask for a value that does not exist named "(.+)" that has a default block returning "(.+)"$/) do |key, value|
  @value = FigNewton.send(key) {
    value
  }    
end

When (/^I ask for a value that does not exist named "(.+)" that has a default lambda returning "(.+)"$/) do |key, value|
  mylambda = lambda {|property| @lambda_property = property; return value}
  @value = FigNewton.send key, &mylambda
end

When (/^I ask for a value that does not exist named "(.+)" that has a default proc returning "(.+)"$/) do |key, value|
  myproc = Proc.new {value}
  @value = FigNewton.send(key, &myproc)  
end

Then (/^the lambda should be passed the property "(.+)"$/) do |expected_property|
  expect(@lambda_property).to eq(expected_property)
end

Given(/^I have an environment variable named "(.*?)" set to a comma separated list with the filenames "(.*?)" and "(.*?)"$/) do |env_name, filename1, filename2|
  FigNewton.yml = nil
  ENV[env_name] = "#{filename1},#{filename2}"
  FigNewton.yml_directory = 'config/yaml'
  FigNewton.instance_variable_set(:@yml, nil)
end