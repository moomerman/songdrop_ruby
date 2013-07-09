module Songdrop
  module ImageHelper

    def image_url(options={})
      options[:action] ||= 'crop'
      options[:size] ||= '50x50'
      self.image.gsub('ACTION', options[:action]).gsub('WIDTHxHEIGHT', options[:size])
    end

  end
end