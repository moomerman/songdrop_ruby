module Songdrop
  class User < Base
    include ImageHelper

    def auth_token
      "#{self.id}-#{self.api_token}"
    end

  end
end