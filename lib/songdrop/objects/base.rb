module Songdrop
  class Base
    attr_reader :_properties

    def initialize(properties={})
      @_properties = properties
    end

    def method_missing(method, *args, &block)
      method = $1 if method =~ /(\S+)\?/
      method = method.to_sym
      @_properties[method]
    end

  end
end