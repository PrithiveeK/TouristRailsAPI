class CreateMasterChains < ActiveRecord::Migration[6.0]
  def change
    create_table :master_chains do |t|
      t.string :name, null: false
      t.string :description
      t.string :status, :default => 'ACTIVE'

      t.timestamps
    end
  end
end
