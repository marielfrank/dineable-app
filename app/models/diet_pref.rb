class DietPref < ActiveRecord::Base
  include Slug::InstanceMethods
  extend Slug::ClassMethods

  has_many :restaurant_diet_prefs
  has_many :restaurants, :through => :restaurant_diet_prefs
  has_many :users, :through => :restaurants
end
