module Songdrop
  class Client
    attr_accessor :auth_token

    def initialize(options={})
      @token = options[:token]
      @endpoint = options[:endpoint] || 'https://songdrop.com/v1'
      @auth_token = options[:auth_token]
    end

    def get(path, params={}, &block)
      puts "[Songdrop::Client] get #{path} with #{params.inspect} block? #{block_given?}"
      params.merge!(:client => @token, :token => @auth_token)
      HTTP.get(full_url(path), params) do |response, error|
        handle_response(response, error, &block)
      end
    end

    def put(path, params={}, &block)
      puts "[Songdrop::Client] put #{path} with #{params.inspect} block? #{block_given?}"
      params.merge!(:client => @token, :token => @auth_token)
      HTTP.put(full_url(path), params) do |response, error|
        handle_response(response, error, &block)
      end
    end

    def post(path, params={}, &block)
      puts "[Songdrop::Client] post #{path} with #{params.inspect} block? #{block_given?}"
      params.merge!(:client => @token, :token => @auth_token)
      HTTP.post(full_url(path), params) do |response, error|
        handle_response(response, error, &block)
      end
    end

    def delete(path, params={}, &block)
      puts "[Songdrop::Client] delete #{path} with #{params.inspect} block? #{block_given?}"
      params.merge!(:client => @token, :token => @auth_token)
      HTTP.delete(full_url(path), params) do |response, error|
        handle_response(response, error, &block)
      end
    end

    private
      def full_url(path)
        "#{@endpoint}#{path}"
      end

      def handle_response(response, error, &block)
        target = response || error
        JSON.parse(target) do |obj|
          res = Parser.parse(obj)
          block.call res if block_given?
          res
        end
      end

  end
end