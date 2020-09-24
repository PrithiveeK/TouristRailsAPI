class CreateLocation2Types < ActiveRecord::Migration[6.0]
  def change
    create_table :location2_types do |t|
      t.string :name, null: false, index: {unique: true}
      t.string :description
      t.string :status, :default => 'ACTIVE'

      t.timestamps
    end
  end
end
