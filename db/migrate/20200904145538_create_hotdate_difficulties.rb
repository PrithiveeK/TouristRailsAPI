class CreateHotdateDifficulties < ActiveRecord::Migration[6.0]
  def change
    create_table :hotdate_difficulties do |t|
      t.string :name, null: false, index: {unique: true}
      t.string :description
      t.string :status, :default => 'ACTIVE'
      
      t.timestamps
    end
  end
end
