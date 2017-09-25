class DietPref < ActiveRecord::Base
  has_many :restaurant_diet_prefs
  has_many :restaurants, :through => :restaurant_diet_prefs
  has_many :users, :through => :restaurants
end
