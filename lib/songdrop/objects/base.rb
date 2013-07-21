module Songdrop
  class Base
    attr_reader :_properties

    def initialize(properties={})
      @_properties = properties
    end

    def method_missing(method, *args, &block)
      method = $1 if method =~ /(\S+)\?/
      method = method.to_sym
      result = @_properties[method]
      result = Time.at(result.to_i) if result and method =~ /_at/
      result = Time.at(result.to_i).to_date if result and method =~ /_on/
      result
    end

    def errors?
      !self.errors.nil?
    end

  end
end