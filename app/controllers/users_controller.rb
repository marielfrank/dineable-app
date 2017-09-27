# inherits from ApplicationController
class UserController < ApplicationController
  # allow visit to signup page unless logged in
  get '/signup' do
    # only allow signup if not already logged in
    if logged_in?
      # send to user show/home if logged in
      redirect "/users/#{current_user.slug}"
    else
      erb :'/users/signup'
    end
  end

  # signup form action to create new user
  post '/signup' do
    # instantiate new user based on signup form values
    @user = User.new(username: params[:username], password: params[:password])
    # ensure username and password are not empty, and user can be saved
    if !params[:username].empty? && !params[:password].empty? && @user.save
      # set new session user_id & send user to their homepage
      session[:user_id] = @user.id
      redirect "/users/#{@user.slug}"
    else
      # let user know form was not completed correctly & redirect to signup again
      flash[:message] = "Oops! Looks like you have a field or two that isn't quite right...please try again :)"
      redirect '/signup'
    end
  end

  # allow visit to login page unless logged in
  get '/login' do
    # only allow login if not already logged in
    if logged_in?
      # send to user show/home if logged in
      redirect "/users/#{current_user.slug}"
    else
      erb :'users/login'
    end
  end

  # log in user
  post '/login' do
    # find user by username
    @user = User.find_by(username: params[:username])
    # ensure user exists and password is correct
    if !!@user && @user.authenticate(params[:password])
      # set new session user_id & send user to their homepage
      session[:user_id] = @user.id
      redirect "/users/#{@user.slug}"
    else
      # let user know form was not completed correctly & redirect to login again
      flash[:message] = "Oops! Looks like you have a field or two that isn't quite right...please try again :)"
      redirect '/login'
    end
  end

  # user's show/home page
  get '/users/:slug' do
    # find user by slug
    @user = User.find_by_slug(params[:slug])
    # ensure user exists, is logged in, & is current user
    if !!@user && logged_in? && @user == current_user
      erb :'/users/show'
    elsif logged_in?
      # if logged in under different account, send to own show/home page
      flash[:message] = "Whoops, that wasn't your account! Don't worry, we got you back home."
      redirect "/users/#{current_user.slug}"
    else
      # if not logged in, send to login
      flash[:message] = "Try logging in first..."
      redirect '/login'
    end
  end

  # logout
  post '/logout' do
    # clear session & redirect to login
    session.clear
    redirect '/login'
  end
end
