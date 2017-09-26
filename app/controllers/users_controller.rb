class UserController < ApplicationController
  # allow visit to signup page unless logged in
  get '/signup' do
    if !logged_in?
      erb :'/users/login'
    else
      redirect '/restaurants'
    end
  end

  # signup form action to create new user
  post '/signup' do
    @user = User.new(username: params[:username], password: params[:password])

    if !params[:username].empty? && !params[:password].empty? && @user.save
      session[:user_id] = @user.id
    else
      redirect '/signup'
    end
  end

  # allow visit to login page unless logged in
  get '/login' do

  end

  # logout
  post '/logout' do

  end
end
