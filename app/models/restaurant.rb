class Restaurant < ActiveRecord::Base
  belongs_to :user
  has_many :restaurant_diet_prefs
  has_many :diet_prefs, :through => :restaurant_diet_prefs
end
