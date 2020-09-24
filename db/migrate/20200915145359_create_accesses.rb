class CreateAccesses < ActiveRecord::Migration[6.0]
  def change
    create_table :accesses do |t|
    	t.string :name, null: false
    	t.string :type, null: false
    	t.string :status, :default => 'ACTIVE'

      t.timestamps
    end
  end
end
