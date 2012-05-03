require "fig_newton/version"

module FigNewton

  class << self

    attr_reader :fig_newton_yml_directory

    def yml_directory
      @fig_newton_yml_directory ||= 'config/environments'
    end

    def yml_directory=(value)
      @fig_newton_yml_directory = value
    end

    def load(filename)
      @yaml = YAML.load_file "#{FigNewton.fig_newton_yml_directory}/#{filename}"
    end

    def method_missing(*args, &block)
      m = args.first
      value = @yaml[m.to_s]
      super unless value
      value
    end
  end
end
