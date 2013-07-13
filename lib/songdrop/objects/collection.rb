module Songdrop
  class Collection < Array
    attr_reader :_properties

    def initialize(properties={})
      @_properties = properties
    end

    def method_missing(method, *args, &block)
      method = $1 if method =~ /(\S+)\?/
      method = method.to_s
      return @_properties[method] if @_properties.has_key?(method)
      method = method.to_sym # super requires a symbol
      super
    end

  end
end