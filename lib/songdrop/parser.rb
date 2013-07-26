module Songdrop
  class Parser

    def self.parse(response, headers={})

      if response.is_a?(Hash) and response['object']

        # we only got one object back
        return objectize(response['object'], parse_object(response, headers))

      elsif response.is_a?(Hash)

        # we got a hash pointer to objects
        return response.keys.collect do |object|
          objectize(object, parse_object(response[object], headers))
        end

      elsif response.is_a? Array

        # we got an array of objects back
        result = response.collect do |object|
          properties = parse_object(object, headers)
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

    def self.parse_object(hash, headers={})
      # puts "[Songdrop::Parser] PARSE #{hash.inspect}"
      properties = {}

      hash.keys.each do |property|
        # puts "[Songdrop::Parser] #{property} is a #{property.class}"
        if hash[property].is_a?(Array)
          # puts "[Songdrop::Parser] parsing array #{property}"
          objects = []
          hash[property].each do |el|
            objects << objectize(el['object'], parse_object(el))
          end

          pagination = JSON.parse(headers[:x_pagination]) if headers[:x_pagination]
          if pagination and pagination['element'] == property
            collection = Collection.new(pagination)
            objects = collection.replace(objects)
          end

          properties[property.to_sym] = objects
        elsif hash[property].is_a?(Hash) and hash[property]['object']
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
        when :play then Play.new(properties)
        when :like then Like.new(properties)
        when :following then Following.new(properties)
        when :error then Error.new(properties)
        when :errors then Errors.new(properties)
        else "[Songdrop::Parser] Don't know how to objectize #{type}"
      end
    end

  end
end