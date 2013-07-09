require 'json'

module Songdrop
  class JSON

    def self.parse(json, &block)
      block.call ::JSON.parse(json)
    end

  end
end