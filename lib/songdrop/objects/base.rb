module Songdrop
  class Base
    attr_reader :_properties

    def initialize(properties={})
      @_properties = properties
    end

    def method_missing(method, *args, &block)
      method = $1 if method =~ /(\S+)\?/
      method = method.to_sym
      return @_properties[method] if @_properties.has_key?(method)
      super
    end

  end
end