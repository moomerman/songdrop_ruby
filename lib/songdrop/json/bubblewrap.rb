module Songdrop
  class JSON

    def self.parse(json, &block)
      result = ::BubbleWrap::JSON.parse(json)
      block.call result if block
      result
    end

  end
end