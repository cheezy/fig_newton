module FigNewton
  module Missing
    def method_missing(*args, &block)
      read_env_file unless @yml
      m = args.first
      value = @yml[m.to_s]
      super unless value
      value = FigNewton::Node.new(value) unless value.kind_of? String
      value
    end

    def read_env_file
      @yml = YAML.load_file "#{@yml_directory}/#{ENV['FIG_NEWTON_FILE']}"
    end
  end
end
