class CreateCurrencies < ActiveRecord::Migration[6.0]
  def change
    create_table :currencies do |t|
      t.string :name, null: false, index: {unique: true}
      t.string :description
      t.boolean :is_sales, null: false, :default => false
      t.string :status, :default => 'ACTIVE'
      
      t.timestamps
    end
  end
end
