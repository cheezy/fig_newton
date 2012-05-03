$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '../../', 'lib'))

require 'rspec/expectations'
require 'fig_newton'

FigNewton.yml_directory = 'config/yaml'
