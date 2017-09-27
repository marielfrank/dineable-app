# This file tells Rack and Shotgun the environment requirements
# of the application and starts the application

# requiring absolute path for environment but could also be:
# require_relative 'config/environment'
require './config/environment'

# ensure that database is properly loaded with migrations
if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

# Middleware for Rack
use Rack::MethodOverride
# Tell app to use these controllers
use UserController
use RestaurantController
use DietPrefController
# Tell app to run the ApplicationController
run ApplicationController
