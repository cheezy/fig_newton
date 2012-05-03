require "fig_newton/version"
require 'yml_reader'

module FigNewton
  extend YmlReader

  def self.default_directory
    'config/environments'
  end

  def self.method_missing(*args, &block)
    m = args.first
    value = @yml[m.to_s]
    super unless value
    value
  end
end
