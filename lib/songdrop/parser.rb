module Songdrop
  class Parser

    def self.parse(response, headers={})

      puts "HEADERS: #{headers[:x_pagination].inspect}"

      if response.is_a?(Hash) and response['object']

        # we only got one object back
        return objectize(response['object'], parse_object(response))

      elsif response.is_a?(Hash)

        # we got a hash pointer to objects
        return response.keys.collect do |object|
          objectize(object, parse_object(response[object]))
        end

      elsif response.is_a? Array

        # we got an array of objects back
        result = response.collect do |object|
          properties = parse_object(object)
          objectize(object['object'], properties)
        end

        if headers[:x_pagination]
          collection = Collection.new(JSON.parse(headers[:x_pagination]))
          collection.replace(result)
          return collection
        else
          return result
        end

      else
        puts "[Songdrop::Parser] Unexpected response type #{response.class}"
        return response
      end
    end

    def self.parse_object(hash)
      # puts "[Songdrop::Parser] PARSE #{hash.inspect}"
      properties = {}

      hash.keys.each do |property|
        # puts "[Songdrop::Parser] #{property} is a #{property.class}"
        if hash[property].is_a? Array
          # puts "[Songdrop::Parser] parsing array #{property}"
          objects = []
          hash[property].each do |el|
            objects << objectize(el['object'], parse_object(el))
          end
          properties[property.to_sym] = objects
        elsif hash[property].is_a? Hash
          # puts "[Songdrop::Parser] parsing hash #{property} of type #{hash[property]['object']}"
          object = objectize(hash[property]['object'], parse_object(hash[property]))
          properties[property.to_sym] = object
        else
          properties[property.to_sym] = hash[property]
        end
      end

      properties
    end

    def self.objectize(type, properties)
      case type.to_sym
        when :user then User.new(properties)
        when :drop then Drop.new(properties)
        when :song then Song.new(properties)
        when :mix then Mix.new(properties)
        when :artist then Artist.new(properties)
        when :error then Error.new(properties)
        else "[Songdrop::Parser] Don't know how to objectize #{type}"
      end
    end

  end
end