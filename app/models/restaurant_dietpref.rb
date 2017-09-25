class RestaurantDietPref < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :diet_pref
end
