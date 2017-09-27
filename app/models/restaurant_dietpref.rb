# join table for many-to-many relationship between restaurants and diet_prefs
class RestaurantDietPref < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :diet_pref
end
