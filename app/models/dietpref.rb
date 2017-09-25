class DietPref < ActiveRecord::Base
  has_many :restaurant_dietprefs
  has_many :restaurants, :through => :restaurant_dietprefs
  has_many :users, :through => :restaurants
end
