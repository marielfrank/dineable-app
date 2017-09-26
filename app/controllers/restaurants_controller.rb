class RestaurantController < ApplicationController
  get '/restaurants' do
    erb :'restaurants/index'
  end
end
