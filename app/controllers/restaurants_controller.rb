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
      if !params[:diet_pref][:name].empty?
        @restaurant.diet_prefs << DietPref.new(name: params[:diet_pref][:name])
      end
      @restaurant.save
      redirect "/restaurants/#{@restaurant.slug}"
    else
      redirect '/restaurants/new'
    end
  end

  get '/restaurants/:slug/edit' do
    @restaurant = Restaurant.find_by_slug(params[:slug])
    if !!@restaurant && logged_in? && current_user.restaurants.include?(@restaurant)
      erb :'/restaurants/edit'
    elsif logged_in?
      redirect "/restaurants/#{@restaurant.slug}"
    else
      redirect '/login'
    end
  end

  post '/restaurants/:slug' do
    @restaurant = Restaurant.find_by_slug(params[:slug])
    @restaurant.update(params[:restaurant])
    if !params[:diet_pref][:name].empty?
      @restaurant.diet_prefs << DietPref.new(name: params[:diet_pref][:name])
    end
    @restaurant.save
    redirect "/restaurants/#{@restaurant.slug}"
  end

  post '/restaurants/:slug/delete' do
    @restaurant = Restaurant.find_by_slug(params[:slug])
    if !!@restaurant && logged_in? && current_user.restaurants.include?(@restaurant)
      @restaurant.delete
      redirect '/restaurants'
    elsif logged_in?
      redirect "/restaurants/#{@restaurant.slug}"
    else
      redirect '/login'
    end
  end
end
