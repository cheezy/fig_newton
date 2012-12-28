require 'yaml'

module FigNewton
  module Missing
    def method_missing(*args, &block)
      read_file unless @yml
      m = args.first
      value = @yml[m.to_s]
      super unless value
      value = FigNewton::Node.new(value) unless type_known? value
      value
    end

    def read_file
      @yml = YAML.load_file "#{yml_directory}/#{ENV['FIG_NEWTON_FILE']}" if ENV['FIG_NEWTON_FILE']
      FigNewton.load('default.yml') unless ENV['FIG_NEWTON_FILE']
    end

    private
    def type_known?(value)
       value.kind_of? String or value.kind_of? Integer
    end
  end
end
