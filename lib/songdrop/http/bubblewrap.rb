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
          begin #in case we don't receive JSON back, we don't want the app to crash:
            json = BubbleWrap::JSON.parse(response.body.to_str)
            block.call response, json
          rescue
            block.call response, nil
          end
        else
          block.call response, nil
        end
      end
    end

  end
end