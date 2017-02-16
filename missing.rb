require 'yaml'
require 'socket'

module FigNewton
  module Missing
    def method_missing(*args, &block)
      read_file unless @yml
      m = args.first
      value = @yml[m.to_s]
      value = args[1] if value.nil?
      value = block.call(m.to_s) if value.nil? and block
      super if value.nil?
      value = FigNewton::Node.new(value) unless type_known? value
      value
    end

    def read_file
      @yml = nil
      @yml = YAML.load_file "#{yml_directory}/#{ENV['FIG_NEWTON_FILE']}" if ENV['FIG_NEWTON_FILE']
      unless @yml
        hostname = Socket.gethostname
        hostfile = "#{yml_directory}/#{hostname}.yml"
        @yml = YAML.load_file hostfile if File.exist? hostfile
      end
      FigNewton.load('default.yml') if @yml.nil?
    end

    private

    def type_known?(value)
      known_types = [String, Integer, TrueClass, FalseClass, Symbol, Float]
      known_types.any? { |type| value.kind_of? type }
    end
  end
end
