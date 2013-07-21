module Songdrop
  class Client

    def login(params, &block)
      post('/session', params) do |user|
        @auth_token = user.auth_token
        block.call user if block
        user
      end
    end

    def signup(params, &block)
      post('/users', params) do |user|
        @auth_token = user.auth_token
        block.call user if block
        user
      end
    end

  end
end