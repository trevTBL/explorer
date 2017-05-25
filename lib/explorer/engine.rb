require 'underscore-rails'
require 'gmaps4rails'
require 'ice_cube'

module Explorer
  class Engine < ::Rails::Engine
    isolate_namespace Explorer

    config.to_prepare do
	    Rails.application.config.assets.precompile += %w(
	      explorer/*
	      explorer/jquery.cubeportfolio.js
	      explorer/main.js
	      )
	  end
  end
end
