$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "explorer/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "explorer"
  s.version     = Explorer::VERSION
  s.authors     = ["dom-dom-dom"]
  s.email       = ["it@dominicmliddell.com"]
  s.homepage    = "http://dominicmliddell.com"
  s.summary     = "Summary of Explorer."
  s.description = "Description of Explorer."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "4.2.7.1"
  s.add_dependency 'ice_cube'
  s.add_dependency 'geocoder'
  s.add_dependency 'gmaps4rails'
  s.add_dependency 'underscore-rails'
  
  s.add_development_dependency "sqlite3"
end
