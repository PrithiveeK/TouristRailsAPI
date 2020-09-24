class CreateCurrencies2s < ActiveRecord::Migration[6.0]
  def change
    create_table :currencies2s do |t|
      t.string :name, null: false, index: {unique: true}
      t.string :description
      t.string :status, :default => 'ACTIVE'
      
      t.timestamps
    end
  end
end
