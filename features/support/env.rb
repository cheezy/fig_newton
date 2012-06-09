$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '../../', 'lib'))

require 'rspec/expectations'
require 'fig_newton'

Before do
  FigNewton.yml_directory = nil
  ENV.delete 'FIG_NEWTON_FILE'
end


