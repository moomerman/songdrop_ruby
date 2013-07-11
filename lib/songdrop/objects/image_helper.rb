module Songdrop
  module ImageHelper

    def image(options={})
      options[:action] ||= 'crop'
      options[:size] ||= '50x50'
      self.image_url.gsub('ACTION', options[:action]).gsub('WIDTHxHEIGHT', options[:size])
    end

  end
end