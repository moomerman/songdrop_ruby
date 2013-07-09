if ENV['RUBYMOTION'] and !ENV['RUBYMOTION'].blank?
  require_relative './http/bubblewrap'
  require_relative './json/bubblewrap'
else
  require_relative './http/rest-client'
  require_relative './json/json'
end

require_relative './parser'

module Songdrop
  class Client

    def initialize(options={})
      @token = options[:token]
      @endpoint = options[:endpoint] || 'https://songdrop.com/v1'
      @auth_token = options[:auth_token]
    end

    def get(path, params={}, &block)
      puts "[Songdrop::Client] get #{path} with #{params.inspect}"
      params.merge!(:client => @token, :token => @auth_token)
      res = nil
      HTTP.get(full_url(path), params) do |response, error|
        res = handle_response(response, error, block)
      end
      res
    end

    def put(path, params={}, &block)
      puts "[Songdrop::Client] put #{path} with #{params.inspect}"
      params.merge!(:client => @token, :token => @auth_token)
      res = nil
      HTTP.put(full_url(path), params) do |response, error|
        res = handle_response(response, error, block)
      end
      res
    end

    def post(path, params={}, &block)
      puts "[Songdrop::Client] post #{path} with #{params.inspect}"
      params.merge!(:client => @token, :token => @auth_token)
      res = nil
      HTTP.post(full_url(path), params) do |response, error|
        res = handle_response(response, error, block)
      end
      res
    end

    def delete(path, params={}, &block)
      puts "[Songdrop::Client] delete #{path} with #{params.inspect}"
      params.merge!(:client => @token, :token => @auth_token)
      res = nil
      HTTP.delete(full_url(path), params) do |response, error|
        res = handle_response(response, error, block)
      end
      res
    end

    private
      def full_url(path)
        "#{@endpoint}#{path}"
      end

      def handle_response(response, error, block)
        target = response || error
        res = nil
        JSON.parse(target) do |obj|
          res = Parser.parse(obj).first
          block.call res if block_given?
        end
        res
      end

  end
end