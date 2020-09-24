class CreateAmenities < ActiveRecord::Migration[6.0]
  def change
    create_table :amenities do |t|
      t.string :name, null: false, :unique => true
      t.string :description
      t.references :service_type, null: false, foreign_key: true
      t.string :status, :default => 'ACTIVE'

      t.timestamps
    end
  end
end
