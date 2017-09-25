class CreateRestaurantDietPrefs < ActiveRecord::Migration[5.1]
  def change
    create_table :restaurant_diet_prefs do |t|
      t.integer :restaurant_id
      t.integer :diet_pref_id
    end
  end
end
