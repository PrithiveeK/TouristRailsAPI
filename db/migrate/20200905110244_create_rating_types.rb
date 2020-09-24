class CreateRatingTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :rating_types do |t|
      t.string :name, null: false, index: {unique: true}
      t.string :description
      t.string :status, :default => 'ACTIVE'
      
      t.timestamps
    end
  end
end
