require File.dirname(__FILE__) + "/missing"

module FigNewton
  class Node
    include FigNewton::Missing
    
    def initialize(yml)
      @yml = yml
    end
  end
end
