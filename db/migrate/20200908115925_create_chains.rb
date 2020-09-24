class CreateChains < ActiveRecord::Migration[6.0]
  def change
    create_table :chains do |t|
      t.string :name, null: false
      t.string :description
      t.references :master_chain, null: false, foreign_key: true
      t.references :service_type, foreign_key: true
      t.string :status, :default => 'ACTIVE'

      t.timestamps
    end
  end
end
