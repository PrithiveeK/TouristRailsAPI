class CreateUserAccessMappings < ActiveRecord::Migration[6.0]
  def change
    create_table :user_access_mappings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :access, null: false, foreign_key: true
      t.string :status, :default => 'ACTIVE'

      t.timestamps
    end
  end
end
