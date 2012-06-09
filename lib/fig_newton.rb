require 'fig_newton/version'
require 'fig_newton/node'
require 'fig_newton/missing'
require 'yml_reader'

module FigNewton
  extend YmlReader
  extend FigNewton::Missing


  class << self
    attr_accessor :yml

    def default_directory
      'config/environments'
    end
  end
end
