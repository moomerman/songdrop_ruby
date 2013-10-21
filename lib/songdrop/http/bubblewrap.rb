module Songdrop
  class HTTP

    def self.get(url, params={}, &block)
      http_request(:get, url, params, &block)
    end

    def self.post(url, params={}, &block)
      http_request(:post, url, params, &block)
    end

    def self.put(url, params={}, &block)
      http_request(:put, url, params, &block)
    end

    def self.delete(url, params={}, &block)
      http_request(:delete, url, params, &block)
    end

    def self.http_request(method, url, options={}, &block)
      bw_options = {:payload => options}
      bw_options.merge!({:headers => {:Accept => "application/json"}})

      puts "[Songdrop::HTTP] #{method} #{url} with: #{bw_options.inspect}"

      BubbleWrap::HTTP.send(method, url, bw_options) do |response|
        if response.ok?
          block.call response.body.to_str, response.headers, nil
        else
          block.call nil, response.headers, response.body.to_str
        end
      end
    end

  end
end