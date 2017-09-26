class RestaurantController < ApplicationController
  get '/restaurants' do
    erb :'restaurants/index'
  end

  get '/restaurants/:slug' do
    @restaurant = Restaurant.find_by_slug(params[:slug])
    if !!@restaurant
      erb :'restaurants/show'
    else
      redirect '/restaurants'
    end
  end
end
