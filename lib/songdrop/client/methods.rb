module Songdrop
  class Client

    def login(params, &block)
      post('/session', params) do |user|
        block.call user if block_given?
        user
      end
    end

  end
end