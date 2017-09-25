class Restaurant < ActiveRecord::Base
  belongs_to :user
  has_many :restaurant_dietprefs
  has_many :dietprefs, :through => :restaurant_dietprefs
end
