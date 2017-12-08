require 'yaml'
require 'socket'
require 'erb'

module FigNewton
  module Missing
    def method_missing(*args, &block)
      read_file unless @yml
      method_name = args.first.to_s
      value = @yml[method_name]

      # If the requested key is not found and an argument was provided, return the argument.
      # FigNewton.something("MyDefault") returns "MyDefault".
      value = args[1] if value.nil?

      # If there is still no value to return but a block was given, it will will run the block with the method name to try to produce a non-nil value.
      value = block.call(method_name) if value.nil? and block

      # If after all the procedures above value is still nil, then call #method_missing in the superclass.
      super if value.nil?

      value = FigNewton::Node.new(value) unless type_known? value
      value
    end

    def read_file
      @yml = nil
      
      # Loads the .yml file content "as is" (including any <% ... %> or <%= ... %> embedded Ruby tags).
      yml_content = File.read("#{yml_directory}/#{ENV['FIG_NEWTON_FILE']}")
      
      # Yields the content to ERB and processes any embedded Ruby in it, obtaining valid YAML.
      processed_template = ERB.new(yml_content).result(binding)

      # Loads the YAML data as a Ruby hash.
      @yml = ::YAML.load(processed_template) if ENV['FIG_NEWTON_FILE']

      unless @yml
        hostname = Socket.gethostname
        hostfile = "#{yml_directory}/#{hostname}.yml"
        @yml = YAML.load_file hostfile if File.exist? hostfile
      end
      FigNewton.load('default.yml') if @yml.nil?
    end

    private

    def type_known?(value)
      known_types = [String, Integer, TrueClass, FalseClass, Symbol, Float, Array]
      known_types.any? { |type| value.kind_of? type }
    end
  end
end
