module Songdrop
  class Client

    def login(params, &block)
      user = post('/session', params)
      @auth_token = user.auth_token
      block.call user if block_given?
      user
    end

  end
end