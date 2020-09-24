class CreateCoachSizeTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :coach_size_types do |t|
      t.string :coach_size, null: false, index: {unique: true}
      t.string :description
      t.string :status, :default => 'ACTIVE'

      t.timestamps
    end
  end
end
