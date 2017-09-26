class UserController < ApplicationController
  # allow visit to signup page unless logged in
  get '/signup' do
    if logged_in?
      redirect "/#{current_user.slug}"
    else
      erb :'/users/signup'
    end
  end

  # signup form action to create new user
  post '/signup' do
    @user = User.new(username: params[:username], password: params[:password])

    if !params[:username].empty? && !params[:password].empty? && @user.save
      session[:user_id] = @user.id
      redirect "/#{@user.slug}"
    else
      redirect '/signup'
    end
  end

  # allow visit to login page unless logged in
  get '/login' do
    if logged_in?
      redirect "/#{current_user.slug}"
    else
      erb :'users/login'
    end
  end

  # log in user
  post '/:username' do

  end

  # user's page if signed in as that user
  get '/:username' do
    @user = User.find_by_slug(params[:username])
    if !!@user && logged_in? && @user == current_user
      erb :'/users/show'
    elsif logged_in?
      redirect "/#{current_user.slug}"
    else
      redirect '/login'
    end
  end

  # logout
  post '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/login'
    end
  end
end
