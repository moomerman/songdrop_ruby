module Songdrop
  class JSON

    def self.parse(response, &block)
      block.call ::BubbleWrap::JSON.parse(response.body.to_str)
    end

  end
end