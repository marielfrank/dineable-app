# set up sinatra environment as dev unless otherwise specified
ENV['SINATRA_ENV'] ||= "development"

# bundler to set up gemfile
require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

# set up ActiveRecord database connection with sqlite
ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)

# require all files within app folder
require_all 'app'
