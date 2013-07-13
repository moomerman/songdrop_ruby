module Songdrop
  class HTTP

    def self.get(url, params={}, &block)
      begin
        response = RestClient.get(url, :params => params)
        block.call response, response.headers, nil
      rescue => e
        puts "[Songdrop::HTTP] Error: #{e.inspect}"
        block.call nil, e.response.headers, e.response
      end
    end

    def self.put(url, params={}, &block)
      begin
        response = RestClient.put(url, params)
        block.call response, response.headers, nil
      rescue => e
        puts "[Songdrop::HTTP] Error: #{e.inspect}"
        block.call nil, e.response.headers, e.response
      end
    end

    def self.post(url, params={}, &block)
      begin
        response = RestClient.post(url, params)
        block.call response, response.headers, nil
      rescue => e
        puts "[Songdrop::HTTP] Error: #{e.inspect}"
        block.call nil, e.response.headers, e.response
      end
    end

    def self.delete(url, params={}, &block)
      begin
        response = RestClient.delete(url, params)
        block.call response, response.headers, nil
      rescue => e
        puts "[Songdrop::HTTP] Error: #{e.inspect}"
        block.call nil, e.response.headers, e.response
      end
    end

  end
end