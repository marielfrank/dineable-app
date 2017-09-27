class DietPrefController < ApplicationController
  get '/dietary-preferences' do
    erb :'diet_prefs/index'
  end

  get '/dietary-preferences/:slug' do
    @dietpref = DietPref.find_by_slug(params[:slug])
    erb :'diet_prefs/show'
  end
end
