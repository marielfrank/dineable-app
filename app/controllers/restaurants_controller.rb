class RestaurantController < ApplicationController
  get '/restaurants' do
    erb :'restaurants/index'
  end

  get '/restaurants/new' do
    if logged_in?
      erb :'/restaurants/new'
    else
      redirect '/login'
    end
  end

  get '/restaurants/:slug' do
    @restaurant = Restaurant.find_by_slug(params[:slug])
    if !!@restaurant
      erb :'restaurants/show'
    else
      redirect '/restaurants'
    end
  end

  post '/restaurants' do
    if !params[:restaurant][:name].empty?
      @restaurant = Restaurant.create(params[:restaurant])
      @restaurant.user = current_user
      @restaurant.diet_prefs << DietPref.new(name: params[:diet_pref])
      @restaurant.save
      redirect "/restaurants/<%= @restaurant.slug %>"
    else
      redirect '/restaurants/new'
    end
  end
end
