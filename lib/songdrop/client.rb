module Songdrop
  class Client
    attr_accessor :auth_token

    def initialize(options={})
      @token = options[:token]
      @endpoint = options[:endpoint] || 'https://songdrop.com/v1'
      @auth_token = options[:auth_token]
    end

    def get(path, params={}, &block)
      puts "[Songdrop::Client] GET #{path} with #{params.inspect} block? #{block_given?}"
      params.merge!(:client => @token, :token => @auth_token)
      HTTP.get(full_url(path), params) do |response, headers, error|
        handle_response(response, headers, error, &block)
      end
    end

    def put(path, params={}, &block)
      puts "[Songdrop::Client] PUT #{path} with #{params.inspect} block? #{block_given?}"
      params.merge!(:client => @token, :token => @auth_token)
      HTTP.put(full_url(path), params) do |response, headers, error|
        handle_response(response, headers, error, &block)
      end
    end

    def post(path, params={}, &block)
      puts "[Songdrop::Client] POST #{path} with #{params.inspect} block? #{block_given?}"
      params.merge!(:client => @token, :token => @auth_token)
      HTTP.post(full_url(path), params) do |response, headers, error|
        handle_response(response, headers, error, &block)
      end
    end

    def delete(path, params={}, &block)
      puts "[Songdrop::Client] DELETE #{path} with #{params.inspect} block? #{block_given?}"
      params.merge!(:client => @token, :token => @auth_token)
      HTTP.delete(full_url(path), params) do |response, headers, error|
        handle_response(response, headers, error, &block)
      end
    end

    private
      def full_url(path)
        "#{@endpoint}#{path}"
      end

      def handle_response(response, headers, error, &block)
        target = response || error
        res = nil
        JSON.parse(target) do |obj|
          res = Parser.parse(obj, headers)
          block.call res if block
          res
        end
        res
      end

  end
end