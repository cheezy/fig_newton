require 'spec_helper'

describe FigNewton do
  context "when configuring the yml directory" do
    it "should default to a directory named config/environments" do
      FigNewton.yml_directory.should == 'config/environments'
    end

    it "should store a yml directory" do
      FigNewton.yml_directory = 'other_directory'
      FigNewton.yml_directory.should == 'other_directory'
    end
  end

  context "when reading yml files" do
    it "should read files from the yml_directory" do
      FigNewton.yml_directory = 'conf'
      YAML.should_receive(:load_file).with('conf/test').and_return({})
      FigNewton.load('test')
    end
  end

  context "when asking for data" do
    it "should retrieve the data by a key named after the method called" do
      FigNewton.yml_directory = 'conf'
      yml_mock = double('yaml')
      YAML.should_receive(:load_file).with('conf/test').and_return(yml_mock)
      yml_mock.should_receive(:[]).with('desired_data').and_return('information')
      FigNewton.load('test')
      FigNewton.desired_data.should == 'information'
    end
  end
end

