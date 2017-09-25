class User < ActiveRecord::Base
  has_many :restaurants
  has_many :restaurant_dietprefs, :through => :restaurants
  has_many :dietprefs, :through => :restaurant_dietprefs
end
