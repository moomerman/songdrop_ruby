module Songdrop
  class HTTP

    def self.get(url, params={}, &block)
      begin
        block.call(RestClient.get(url, :params => params), nil)
      rescue => e
        puts "[Songdrop::HTTP] Error: #{e.inspect}"
        block.call(nil, e.response)
      end
    end

    def self.put(url, params={}, &block)
      begin
        block.call(RestClient.put(url, params), nil)
      rescue => e
        puts "[Songdrop::HTTP] Error: #{e.inspect}"
        block.call nil, e.response
      end
    end

    def self.post(url, params={}, &block)
      begin
        block.call(RestClient.post(url, params), nil)
      rescue => e
        puts "[Songdrop::HTTP] Error: #{e.inspect}"
        block.call(nil, e.response)
      end
    end

    def self.delete(url, params={}, &block)
      begin
        block.call(RestClient.delete(url, params), nil)
      rescue => e
        puts "[Songdrop::HTTP] Error: #{e.inspect}"
        block.call(nil, e.response)
      end
    end

  end
end