module FigNewton
  module Missing
    def method_missing(*args, &block)
      m = args.first
      value = @yml[m.to_s]
      super unless value
      value = FigNewton::Node.new(value) unless value.kind_of? String
      value
    end
  end
end
