module Songdrop
  class JSON

    def self.parse(json, &block)
      block.call ::BubbleWrap::JSON.parse(json)
    end

  end
end