class CreateHotdates < ActiveRecord::Migration[6.0]
  def change
    create_table :hotdates do |t|
      t.string :name, null: false
      t.date :from_date
      t.date :to_date
      t.boolean :is_all_country
      t.integer :country_id
      t.boolean :is_all_city
      t.integer :city_id
      t.string :description
      t.references :hotdate_difficulty, null: false, foreign_key: true
      t.string :status, :default => 'ACTIVE'

      t.timestamps
    end
  end
end
