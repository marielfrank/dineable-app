class DietPrefController < ApplicationController
  # allow anyone to visit dietary preferences index page
  get '/dietary-preferences' do
    erb :'diet_prefs/index'
  end

  # allow anyone to visit restaurants index page
  get '/dietary-preferences/:slug' do
    # find instance of DietPref by slug
    @dietpref = DietPref.find_by_slug(params[:slug])
    erb :'diet_prefs/show'
  end
end
