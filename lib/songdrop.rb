if defined? Motion::Project::Config

  Motion::Project::App.setup do |app|
    Dir.glob(File.join(File.dirname(__FILE__), 'songdrop/*.rb')).each do |file|
      app.files.unshift(file)
    end
    Dir.glob(File.join(File.dirname(__FILE__), 'songdrop/*/*.rb')).each do |file|
      app.files.unshift(file)
    end
  end

else

  require 'rest-client'
  require 'json'

  require_relative './songdrop/parser'
  require_relative './songdrop/client'
  require_relative './songdrop/client/methods'
  require_relative './songdrop/objects/base'
  require_relative './songdrop/objects/image_helper'
  require_relative './songdrop/objects/user'
  require_relative './songdrop/objects/drop'
  require_relative './songdrop/objects/song'
  require_relative './songdrop/objects/mix'
  require_relative './songdrop/objects/artist'
  require_relative './songdrop/objects/error'
  require_relative './songdrop/http/rest-client'
  require_relative './songdrop/json/json'
end

module Songdrop
end