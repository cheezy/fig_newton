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

      if ENV['FIG_NEWTON_FILE']
        files_to_read = env_files

        @yml = files_to_read.inject({}) do |total_merge,file|
          total_merge.merge!(YAML.load_file "#{yml_directory}/#{file}")
        end
      end

      unless @yml
        hostname = Socket.gethostname
        hostfile = "#{yml_directory}/#{hostname}.yml"
        @yml = YAML.load_file hostfile if File.exist? hostfile
      end
      FigNewton.load('default.yml') if @yml.nil?
    end

    private

    def env_files
      content = ENV['FIG_NEWTON_FILE']
      content.include?(',') ? content.split(',') : [content]
    end

    def type_known?(value)
      known_types = [String, Integer, TrueClass, FalseClass]
      known_types.any? { |type| value.kind_of? type }
    end
  end
end
