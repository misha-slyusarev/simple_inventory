$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "simple_inventory_management/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "simple_inventory_management"
  s.version     = SimpleInventoryManagement::VERSION
  s.authors     = ["Mikhail"]
  s.email       = ["mik3weider@gmail.com"]
  s.homepage    = ''
  s.summary     = 'Allows to manipulate of amount of items'
  s.description = 'Allows to manipulate of amount of items'
  s.license     = 'MIT'

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency 'rails', '~> 4.2.1'

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
end
