class CreateServices < ActiveRecord::Migration[6.0]
  def change
    create_table :services do |t|
      t.references :service_type, null: false, foreign_key: true
      t.string :name, null: false
      t.timestamp :start_time
      t.timestamp :end_time
      t.references :country, null: false, foreign_key: true
      t.references :city, null: false, foreign_key: true
      t.string :zipcode
      t.string :fax
      t.string :phone_no
      t.string :telephone_no
      t.string :email
      t.string :website
      t.string :street
      t.string :description
      t.float :lat
      t.float :lng
      t.references :chain, foreign_key: true
      t.string :rating
      t.references :location_type, foreign_key: true
      t.references :location2_type, foreign_key: true
      t.integer :no_of_rooms
      t.references :style, foreign_key: true
      t.integer :seats
      t.boolean :is_unesco, :default => false
      t.boolean :has_ac, :default => false
      t.boolean :is_preferred, :default => false
      t.boolean :is_hotel, :default => false
      t.boolean :is_licensed, :default => false
      t.string :code, null: false    
      t.boolean :placeholder, :default => false
      t.boolean :is_99A_service, :default => false
      t.string :status, :default => 'ACTIVE'

      t.timestamps
    end
  end
end
