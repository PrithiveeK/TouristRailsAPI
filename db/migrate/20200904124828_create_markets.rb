class CreateMarkets < ActiveRecord::Migration[6.0]
  def change
    create_table :markets do |t|
      t.string :name, null: false, index: {unique: true}
      t.string :description
      t.string :status, :default => 'ACTIVE'

      t.timestamps
    end
  end
end
