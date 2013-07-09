module Songdrop
  class Base

    def initialize(properties={})
      @source = OpenStruct.new(properties)
    end

    def method_missing(method, *args, &block)
      @source.send(method, *args, &block)
    end

  end
end