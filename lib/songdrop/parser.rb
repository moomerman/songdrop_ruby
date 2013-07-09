module Songdrop
  class Parser

    def self.parse(response)
      puts response

      if response['object']
        return [objectize(response['object'], parse_object(response))]
      end

      result = []
      objects = response.keys
      objects.each do |object|
       result << objectize(object, parse_object(response[object]))
      end
      result
    end

    def self.parse_object(hash)
      puts "PARSE! #{hash.inspect}"
      properties = {}

      hash.keys.each do |property|
        puts "[Songdrop::Parser] #{property} is a #{property.class}"
        if hash[property].is_a? Array
          puts "[Songdrop::Parser] parsing array #{property}"
          objects = []
          hash[property].each do |el|
            objects << parse_object(el)
          end
          properties[property.to_sym] = objects
        elsif hash[property].is_a? Hash
          puts "[Songdrop::Parser] parsing hash #{property} of type #{hash[property]['object']}"
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
        else "[Songdrop::Parser] Don't know how to objectize #{type}"
      end
    end

  end
end