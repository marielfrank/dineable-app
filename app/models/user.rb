class User < ActiveRecord::Base
  include Slug::InstanceMethods
  extend Slug::ClassMethods

  has_many :restaurants
  has_many :restaurant_diet_prefs, :through => :restaurants
  has_many :diet_prefs, :through => :restaurant_diet_prefs
  has_secure_password

  validates :username, presence: true, uniqueness: true
end
