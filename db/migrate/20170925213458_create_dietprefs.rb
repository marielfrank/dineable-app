class CreateDietPrefs < ActiveRecord::Migration[5.1]
  def change
    create_table :diet_prefs do |t|
      t.string :name
    end
  end
end
