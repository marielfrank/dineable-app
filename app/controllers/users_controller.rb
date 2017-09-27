class UserController < ApplicationController
  # allow visit to signup page unless logged in
  get '/signup' do
    if logged_in?
      redirect "/users/#{current_user.slug}"
    else
      erb :'/users/signup'
    end
  end

  # signup form action to create new user
  post '/signup' do
    @user = User.new(username: params[:username], password: params[:password])

    if !params[:username].empty? && !params[:password].empty? && @user.save
      session[:user_id] = @user.id
      redirect "/users/#{@user.slug}"
    else
      flash[:message] = "Oops! Looks like you have a field or two that isn't quite right...please try again :)"
      redirect '/signup'
    end
  end

  # allow visit to login page unless logged in
  get '/login' do
    if logged_in?
      redirect "/users/#{current_user.slug}"
    else
      erb :'users/login'
    end
  end

  # log in user
  post '/login' do
    @user = User.find_by(username: params[:username])

    if !!@user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/users/#{@user.slug}"
    else
      flash[:message] = "Oops! Looks like you have a field or two that isn't quite right...please try again :)"
      redirect '/login'
    end
  end

  # user's page if signed in as that user
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    if !!@user && logged_in? && @user == current_user
      erb :'/users/show'
    elsif logged_in?
      redirect "/users/#{current_user.slug}"
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
