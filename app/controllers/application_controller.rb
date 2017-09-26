require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    # Set up sessions
    enable :sessions
    set :session_secret, "password_security"
  end

  # allow visit to homepage
  get '/' do
    if logged_in?
      redirect "/#{current_user.slug}"
    else
      erb :index
    end
  end

  helpers do
    # get current user as object
    def current_user
      User.find(session[:user_id])
    end

    # determin if user is logged in
    def logged_in?
      # check if current session has a user_id
      !!session[:user_id]
    end
  end
end
