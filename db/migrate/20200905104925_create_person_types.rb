class CreatePersonTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :person_types do |t|
      t.string :name, null: false, index: {unique: true}
      t.string :description
      t.string :status, :default => 'ACTIVE'
      
      t.timestamps
    end
  end
end
