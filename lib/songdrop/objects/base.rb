module Songdrop
  class Base
    attr_reader :properties

    def initialize(properties={})
      @properties = properties
    end

    def method_missing(method, *args, &block)
      method = "is_#{$1}" if method =~ /(\S+)\?/
      method = method.to_sym
      return @properties[method] if @properties.has_key?(method)
      super
    end

  end
end