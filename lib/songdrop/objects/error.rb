module Songdrop
  class Error < Base
  end

  class Errors < Base

    def on(attribute)
      self.attributes[attribute.to_s]
    end

  end
end