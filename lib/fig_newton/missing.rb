require 'yaml'
require 'socket'

module FigNewton
  module Missing
    def method_missing(*args, &block)
      read_file unless @yml
      m = args.first
      value = @yml[m.to_s]
      value = args[1] unless value
      value = block.call(m.to_s) unless value or block.nil?
      super unless value
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
       value.kind_of? String or value.kind_of? Integer
    end
  end
end
