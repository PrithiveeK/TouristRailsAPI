class CreateRolesAccessesMappings < ActiveRecord::Migration[6.0]
  def change
    create_table :roles_accesses_mappings do |t|
    	t.references :role, null: false, foreign_key: true
    	t.references :access, null: false, foreign_key: true
    	t.string :status, :default => 'ACTIVE'
    	
      t.timestamps
    end
  end
end
