class CreateTitles < ActiveRecord::Migration[6.0]
  def change
    create_table :titles do |t|
      t.string :name, null: false, :unique => true
      t.string :description
      t.string :status, :default => 'ACTIVE'

      t.timestamps
    end
  end
end
