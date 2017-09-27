# requiring absolute path for environment but could also be:
# require_relative '../../config/environment'
require './config/environment'

# inherits from Sinatra::Base
class ApplicationController < Sinatra::Base

  configure do
    # set up public folder
    set :public_folder, 'public'
    # ensure app looks for views in views folder
    set :views, 'app/views'
    # Set up basics for logins and flash messages
    enable :sessions
    set :session_secret, "password_security"
    register Sinatra::Flash
  end

  # allow visit to homepage
  get '/' do
    if logged_in?
      # redirect to user's own show page if logged in
      redirect "/users/#{current_user.slug}"
    else
      erb :index
    end
  end

  helpers do
    # get current user as object
    def current_user
      User.find(session[:user_id])
    end

    # determine if user is logged in
    def logged_in?
      # check if current session has a user_id
      !!session[:user_id]
    end
  end
end
