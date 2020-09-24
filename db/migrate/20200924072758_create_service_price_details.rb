class CreateServicePriceDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :service_price_details do |t|
      t.references :service, null: false, foreign_key: true
      t.string :currency
      t.references :room_type, null: false, foreign_key: true
      t.references :person_type, foreign_key: true
      t.string :pricing_type, null: false
      t.references :charge_type, foreign_key: true
      t.references :menu_type, foreign_key: true
      t.references :breakfast_type, foreign_key: true
      t.string :description
      t.string :type
      t.references :category_type, foreign_key: true
      t.integer :price, null: false

      t.timestamps
    end
  end
end
