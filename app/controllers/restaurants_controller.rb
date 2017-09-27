class RestaurantController < ApplicationController
  # allow anyone to visit restaurants index page
  get '/restaurants' do
    erb :'restaurants/index'
  end

  # allow logged in users to create new restaurants
  get '/restaurants/new' do
    if logged_in?
      erb :'/restaurants/new'
    else
      # if not logged in, send to login
      flash[:message] = "Try logging in first..."
      redirect '/login'
    end
  end

  # create restaurant instance based on form values
  post '/restaurants' do
    # ensure restaurant's name field was filled out
    if !params[:restaurant][:name].empty?
      # create restaurant from restaurant key in params hash
      @restaurant = Restaurant.create(params[:restaurant])
      # set restaurant's user as current user
      @restaurant.user = current_user
      if !params[:diet_pref][:name].empty?
        # if new dietary preference was added, create new DietPref
        # and associate it with the restaurant, then save
        @restaurant.diet_prefs << DietPref.new(name: params[:diet_pref][:name])
        @restaurant.save
      end
      # send user to restaurant's show page
      flash[:message] = "Nice! You added a new restaurant :)"
      redirect "/restaurants/#{@restaurant.slug}"
    else
      # remind user to add name to restaurant if o oname given
      flash[:message] = "Seems like you forgot to add the restaurant's name!"
      redirect '/restaurants/new'
    end
  end

  # allow anyone to visit restaurant show pages
  get '/restaurants/:slug' do
    # make sure restaurant in question exists
    @restaurant = Restaurant.find_by_slug(params[:slug])
    if !!@restaurant
      erb :'restaurants/show'
    else
      # if restaurant is nil, redirect to restaurants index
      flash[:message] = "We can't seem to find that restaurant..."
      redirect '/restaurants'
    end
  end

  # allow user to edit their own restaurants
  get '/restaurants/:slug/edit' do
    # find restaurant by slug
    @restaurant = Restaurant.find_by_slug(params[:slug])
    # ensure restaurant exists, user is logged in & is creator of restaurant
    if !!@restaurant && logged_in? && current_user.restaurants.include?(@restaurant)
      erb :'/restaurants/edit'
    elsif logged_in?
      # send other users to restaurant's show page
      flash[:message] = "Sorry, that's not a restaurant that belongs to you ;)"
      redirect "/restaurants/#{@restaurant.slug}"
    else
      # send users who aren't logged in to login
      flash[:message] = "Try logging in first..."
      redirect '/login'
    end
  end

  # update restaurant based on form values
  # could also be patch route with hidden field
  post '/restaurants/:slug' do
    # ensure restaurant still has a name
    if !params[:restaurant][:name].empty?
      # find restaurant by slug
      @restaurant = Restaurant.find_by_slug(params[:slug])
      # update restaurant from restaurant key in params hash
      @restaurant.update(params[:restaurant])
      if !params[:diet_pref][:name].empty?
        # if new dietary preference was added, create new DietPref
        # and associate it with the restaurant
        @restaurant.diet_prefs << DietPref.new(name: params[:diet_pref][:name])
        @restaurant.save
      end
      # send user to restaurant's show page
      flash[:message] = "Restaurant updated as requested :)"
      redirect "/restaurants/#{@restaurant.slug}"
    else
      # remind user to add name to restaurant if name was removed
      flash[:message] = "Your restaurant just lost a name...can you give it a new one?"
    end
  end

  # allow users to delete own restaurants
  # could also be delete route with hidden form field
  post '/restaurants/:slug/delete' do
    # find restaurant by slug
    @restaurant = Restaurant.find_by_slug(params[:slug])
    if !!@restaurant
      # delete restaurant if it still exists
      @restaurant.delete
      # send users to restaurant index page
      flash[:message] = "Restaurant successfully removed!"
      redirect '/restaurants'
    end
  end
end
