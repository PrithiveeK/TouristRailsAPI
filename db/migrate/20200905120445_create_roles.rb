class CreateRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :roles do |t|
      t.string :name, null: false, index: {unique: true}
      t.string :status, :default => 'ACTIVE'

      t.timestamps
    end
  end
end
