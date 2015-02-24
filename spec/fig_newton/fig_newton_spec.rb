require 'spec_helper'

describe FigNewton do
  context "when asking for data" do
    it "should retrieve the data by a key named after the method called" do
      FigNewton.yml_directory = 'conf'
      yml_mock = double('yaml')
      expect(File).to receive(:read).with('conf/test').and_return('test')
      expect(YAML).to receive(:load).and_return(yml_mock)
      expect(yml_mock).to receive(:[]).with('desired_data').and_return('information')
      FigNewton.load('test')
      expect(FigNewton.desired_data).to eql 'information'
    end
  end
end

