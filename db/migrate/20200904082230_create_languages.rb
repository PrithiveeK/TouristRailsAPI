class CreateLanguages < ActiveRecord::Migration[6.0]
  def change
    create_table :languages do |t|
      t.string :name, null: false, index: {unique: true}
      t.string :description
      t.string :language_iso_code
      t.string :status, :default => 'ACTIVE'

      t.timestamps
    end
  end
end
