module Songdrop
  class Error < Base
    def error?
      true
    end
  end

  class Errors < Base

    def on(attribute)
      self.attributes[attribute.to_s]
    end

  end
end