module Songdrop
  class Base
    attr_reader :properties

    def initialize(properties={})
      @properties = properties
    end

    def method_missing(method, *args, &block)
      @properties[method.to_sym]
    end

  end
end